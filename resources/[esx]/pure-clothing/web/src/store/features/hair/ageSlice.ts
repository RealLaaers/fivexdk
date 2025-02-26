import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface AgeState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: AgeState = {
  baseValue1: 0,
  maxValue1: 14,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const ageSlice = createSlice({
  name: 'age',
  initialState,
  reducers: {
    setAgeForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setAgeBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'age',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setAgeBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'age',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setAgeMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setAgeColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'age',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setAgeColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'age',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setAgeOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'age',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default ageSlice.reducer;
export const {
  setAgeBaseValue1,
  setAgeBaseValue1ByInput,
  setAgeMaxValue1,
  setAgeColourID1,
  setAgeColourID2,
  setAgeOpacity,
  setAgeForFirstTime,
} = ageSlice.actions;
