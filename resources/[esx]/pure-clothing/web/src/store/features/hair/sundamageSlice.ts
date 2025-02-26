import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface SundamageState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: SundamageState = {
  baseValue1: 0,
  maxValue1: 14,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const sundamageSlice = createSlice({
  name: 'sundamage',
  initialState,
  reducers: {
    setSundamageForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setSundamageBaseValue1: (state, action: PayloadAction<number>) => {
      if (action.payload == 0) {
        state.baseValue1 = 0;
        return;
      }
      if (action.payload > 0) {
        if (state.baseValue1 + action.payload < state.maxValue1) {
          state.baseValue1 += action.payload;
        } else {
          state.baseValue1 = state.maxValue1;
        }
      } else {
        if (state.baseValue1 + action.payload > -1) {
          state.baseValue1 += action.payload;
        } else {
          state.baseValue1 = -1;
        }
      }
      sendNui('setAppearance', {
        name: 'sundamage',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setSundamageBaseValue1ByInput: (state, action: PayloadAction<number>) => {
      if (action.payload > 0) {
        if (action.payload < state.maxValue1) {
          state.baseValue1 = action.payload;
        } else {
          state.baseValue1 = state.maxValue1;
        }
      } else {
        if (action.payload > -1) {
          state.baseValue1 = action.payload;
        } else {
          state.baseValue1 = -1;
        }
      }
      sendNui('setAppearance', {
        name: 'sundamage',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setSundamageMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setSundamageColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'sundamage',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setSundamageColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'sundamage',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setSundamageOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'sundamage',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default sundamageSlice.reducer;
export const {
  setSundamageBaseValue1,
  setSundamageBaseValue1ByInput,
  setSundamageMaxValue1,
  setSundamageColourID1,
  setSundamageColourID2,
  setSundamageOpacity,
  setSundamageForFirstTime,
} = sundamageSlice.actions;
