import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface BlemishesState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: BlemishesState = {
  baseValue1: 0,
  maxValue1: 23,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const blemishesSlice = createSlice({
  name: 'blemishes',
  initialState,
  reducers: {
    setBlemishesForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setBlemishesBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'blemishes',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBlemishesBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'blemishes',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBlemishesMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setBlemishesColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'blemishes',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBlemishesColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'blemishes',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBlemishesOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'blemishes',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default blemishesSlice.reducer;
export const {
  setBlemishesBaseValue1,
  setBlemishesBaseValue1ByInput,
  setBlemishesMaxValue1,
  setBlemishesColourID1,
  setBlemishesColourID2,
  setBlemishesOpacity,
  setBlemishesForFirstTime,
} = blemishesSlice.actions;
