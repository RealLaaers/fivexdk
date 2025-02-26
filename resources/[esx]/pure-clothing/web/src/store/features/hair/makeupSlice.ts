import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface MakeupState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: MakeupState = {
  baseValue1: 0,
  maxValue1: 74,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const makeupSlice = createSlice({
  name: 'makeup',
  initialState,
  reducers: {
    setMakeupForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setMakeupBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'makeup',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setMakeupBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'makeup',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setMakeupMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setMakeupColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'makeup',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setMakeupColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'makeup',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setMakeupOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'makeup',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default makeupSlice.reducer;
export const {
  setMakeupBaseValue1,
  setMakeupBaseValue1ByInput,
  setMakeupMaxValue1,
  setMakeupColourID1,
  setMakeupColourID2,
  setMakeupOpacity,
  setMakeupForFirstTime,
} = makeupSlice.actions;
