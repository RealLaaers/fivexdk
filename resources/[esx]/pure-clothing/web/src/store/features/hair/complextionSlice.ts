import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface ComplextionState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: ComplextionState = {
  baseValue1: 0,
  maxValue1: 14,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const complextionSlice = createSlice({
  name: 'complextion',
  initialState,
  reducers: {
    setComplextionForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setComplextionBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'complextion',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setComplextionBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'complextion',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setComplextionMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setComplextionColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'complextion',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setComplextionColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'complextion',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setComplextionOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'complextion',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default complextionSlice.reducer;
export const {
  setComplextionBaseValue1,
  setComplextionBaseValue1ByInput,
  setComplextionMaxValue1,
  setComplextionColourID1,
  setComplextionColourID2,
  setComplextionOpacity,
  setComplextionForFirstTime,
} = complextionSlice.actions;
