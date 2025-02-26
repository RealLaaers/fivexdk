import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface BodyState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: BodyState = {
  baseValue1: 0,
  maxValue1: 11,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const bodySlice = createSlice({
  name: 'body',
  initialState,
  reducers: {
    setBodyForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setBodyBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'body',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBodyBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'body',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBodyMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setBodyColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'body',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBodyColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'body',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBodyOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'body',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default bodySlice.reducer;
export const {
  setBodyBaseValue1,
  setBodyBaseValue1ByInput,
  setBodyMaxValue1,
  setBodyColourID1,
  setBodyColourID2,
  setBodyOpacity,
  setBodyForFirstTime,
} = bodySlice.actions;
