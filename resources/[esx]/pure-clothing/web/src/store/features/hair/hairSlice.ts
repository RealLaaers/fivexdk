import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface HairState {
  baseValue1: number;
  baseValue2: number;
  maxValue1: number;
  maxValue2: number;
  colourID1: number;
  colourID2: number;
  opacity: number;
}

const initialState: HairState = {
  baseValue1: 0,
  baseValue2: 0,
  maxValue1: 60,
  maxValue2: 1,
  colourID1: 1,
  colourID2: 1,
  opacity: 100,
};

export const hairSlice = createSlice({
  name: 'hair',
  initialState,
  reducers: {
    setHairForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setHairBaseValue1: (state, action: PayloadAction<number>) => {
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
        if (state.baseValue1 + action.payload > 0) {
          state.baseValue1 += action.payload;
        } else {
          state.baseValue1 = 0;
        }
      }
      sendNui('setAppearance', { name: 'hair', value: state.baseValue1 });
    },
    setHairBaseValue1ByInput: (state, action: PayloadAction<number>) => {
      if (action.payload > 0) {
        if (action.payload < state.maxValue1) {
          state.baseValue1 = action.payload;
        } else {
          state.baseValue1 = state.maxValue1;
        }
      } else {
        if (action.payload > 0) {
          state.baseValue1 = action.payload;
        } else {
          state.baseValue1 = 0;
        }
      }
      sendNui('setAppearance', { name: 'hair', value: state.baseValue1 });
    },
    setHairMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setHairBaseValue2: (state, action: PayloadAction<number>) => {
      if (action.payload == 0) {
        state.baseValue2 = 0;
        return;
      }
      if (action.payload > 0) {
        if (state.baseValue2 + action.payload < state.maxValue2) {
          state.baseValue2 += action.payload;
        } else {
          state.baseValue2 = state.maxValue2;
        }
      } else {
        if (state.baseValue2 + action.payload > 0) {
          state.baseValue2 += action.payload;
        } else {
          state.baseValue2 = 0;
        }
      }
      sendNui('setTexture', {
        name: 'hair',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
      // sendNui('setAppearance', { name: 'hair', value: state.baseValue1 });
    },
    setHairBaseValue2ByInput: (state, action: PayloadAction<number>) => {
      if (action.payload > 0) {
        if (action.payload < state.maxValue2) {
          state.baseValue2 = action.payload;
        } else {
          state.baseValue2 = state.maxValue2;
        }
      } else {
        if (action.payload > 0) {
          state.baseValue2 = action.payload;
        } else {
          state.baseValue2 = 0;
        }
      }
      sendNui('setTexture', {
        name: 'hair',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
      // sendNui('setAppearance', { name: 'hair', value: state.baseValue1 });
    },
    setHairMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setHairColourID1: (state, action: PayloadAction<number>) => {
      state.colourID1 = action.payload;
      sendNui('setColour', {
        name: 'hair',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setHairColourID2: (state, action: PayloadAction<number>) => {
      state.colourID2 = action.payload;
      sendNui('setColour', {
        name: 'hair',
        colour1: state.colourID1,
        colour2: state.colourID2,
      });
    },
    setHairOpacity: (state, action: PayloadAction<number>) => {
      state.opacity = action.payload;
    },
  },
});

export default hairSlice.reducer;
export const {
  setHairBaseValue1,
  setHairBaseValue1ByInput,
  setHairMaxValue1,
  setHairBaseValue2,
  setHairBaseValue2ByInput,
  setHairMaxValue2,
  setHairColourID1,
  setHairColourID2,
  setHairOpacity,
  setHairForFirstTime,
} = hairSlice.actions;
