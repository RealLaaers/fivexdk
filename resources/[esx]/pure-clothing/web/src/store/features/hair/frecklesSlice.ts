import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface frecklesState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: frecklesState = {
  baseValue1: 0,
  maxValue1: 17,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const frecklesSlice = createSlice({
  name: 'freckles',
  initialState,
  reducers: {
    setFrecklesForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setFrecklesBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'freckles',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setFrecklesBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'freckles',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setFrecklesMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setFrecklesColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'freckles',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setFrecklesColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'freckles',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setFrecklesOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'freckles',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default frecklesSlice.reducer;
export const {
  setFrecklesBaseValue1,
  setFrecklesBaseValue1ByInput,
  setFrecklesMaxValue1,
  setFrecklesColourID1,
  setFrecklesColourID2,
  setFrecklesOpacity,
  setFrecklesForFirstTime,
} = frecklesSlice.actions;
