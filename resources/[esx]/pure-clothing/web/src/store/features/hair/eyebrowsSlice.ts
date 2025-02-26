import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface EyebrowsState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: EyebrowsState = {
  baseValue1: 0,
  maxValue1: 33,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const eyebrowsSlice = createSlice({
  name: 'eyebrows',
  initialState,
  reducers: {
    setEyebrowsForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setEyebrowsBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'eyebrows',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setEyebrowsBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'eyebrows',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setEyebrowsMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setEyebrowsColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'eyebrows',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setEyebrowsColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'eyebrows',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setEyebrowsOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'eyebrows',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default eyebrowsSlice.reducer;
export const {
  setEyebrowsBaseValue1,
  setEyebrowsBaseValue1ByInput,
  setEyebrowsMaxValue1,
  setEyebrowsColourID1,
  setEyebrowsColourID2,
  setEyebrowsOpacity,
  setEyebrowsForFirstTime,
} = eyebrowsSlice.actions;
