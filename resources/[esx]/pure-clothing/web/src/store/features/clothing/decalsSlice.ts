import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface DecalsState {
  baseValue1: number;
  maxValue1: number;
  baseValue2: number;
  maxValue2: number;
}

const initialState: DecalsState = {
  baseValue1: 0,
  maxValue1: 10,
  baseValue2: 0,
  maxValue2: 5,
};

export const decalsSlice = createSlice({
  name: 'decals',
  initialState,
  reducers: {
    setDecalsForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setDecalsBaseValue1: (state, action: PayloadAction<number>) => {
      if (action.payload == 0) {
        state.baseValue1 = 0;
        return;
      }
      if (action.payload > 0) {
        if (state.baseValue1 + action.payload < state.maxValue1 + 1) {
          state.baseValue1 += action.payload;
        } else {
          state.baseValue1 = 0;
        }
      } else {
        if (state.baseValue1 + action.payload > 0) {
          state.baseValue1 += action.payload;
        } else {
          state.baseValue1 = 0;
        }
      }
      sendNui('setAppearance', { name: 'decals', value: state.baseValue1 });
    },
    setDecalsMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setDecalsBaseValue2: (state, action: PayloadAction<number>) => {
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
        name: 'decals',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
    setDecalsMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setDecalsBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'decals', value: state.baseValue1 });
    },
    setDecalsBaseValue2ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'decals',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
  },
});

export default decalsSlice.reducer;
export const {
  setDecalsBaseValue1,
  setDecalsMaxValue1,
  setDecalsBaseValue2,
  setDecalsMaxValue2,
  setDecalsBaseValue1ByInput,
  setDecalsBaseValue2ByInput,
  setDecalsForFirstTime,
} = decalsSlice.actions;
