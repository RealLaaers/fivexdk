import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface ChestState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: ChestState = {
  baseValue1: 0,
  maxValue1: 16,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const chestSlice = createSlice({
  name: 'chest',
  initialState,
  reducers: {
    setChestForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setChestBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'chest',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setChestBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'chest',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setChestMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setChestColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'chest',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setChestColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'chest',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setChestOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'chest',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default chestSlice.reducer;
export const {
  setChestBaseValue1,
  setChestBaseValue1ByInput,
  setChestMaxValue1,
  setChestColourID1,
  setChestColourID2,
  setChestOpacity,
  setChestForFirstTime,
} = chestSlice.actions;
