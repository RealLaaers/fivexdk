import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface BlushState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: BlushState = {
  baseValue1: 0,
  maxValue1: 6,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const blushSlice = createSlice({
  name: 'blush',
  initialState,
  reducers: {
    setBlushForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setBlushBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'blush',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBlushBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'blush',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBlushMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setBlushColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'blush',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBlushColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'blush',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBlushOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'blush',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default blushSlice.reducer;
export const {
  setBlushBaseValue1,
  setBlushBaseValue1ByInput,
  setBlushMaxValue1,
  setBlushColourID1,
  setBlushColourID2,
  setBlushOpacity,
  setBlushForFirstTime,
} = blushSlice.actions;
