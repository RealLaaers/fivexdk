import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface BeardState {
  baseValue1: number;
  maxValue1: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: BeardState = {
  baseValue1: 0,
  maxValue1: 28,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const beardSlice = createSlice({
  name: 'beard',
  initialState,
  reducers: {
    setBeardForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setBeardBaseValue1: (state, action: PayloadAction<number>) => {
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
        name: 'beard',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBeardBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'beard',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
    setBeardMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setBeardColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'beard',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBeardColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'beard',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setBeardOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
      sendNui('setAppearance', {
        name: 'beard',
        value: state.baseValue1,
        opacity: state.opacity,
      });
    },
  },
});

export default beardSlice.reducer;
export const {
  setBeardBaseValue1,
  setBeardBaseValue1ByInput,
  setBeardMaxValue1,
  setBeardColourID1,
  setBeardColourID2,
  setBeardOpacity,
  setBeardForFirstTime,
} = beardSlice.actions;
