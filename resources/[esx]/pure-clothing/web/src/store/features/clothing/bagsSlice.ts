import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface BagsState {
  baseValue1: number;
  maxValue1: number;
  baseValue2: number;
  maxValue2: number;
}

const initialState: BagsState = {
  baseValue1: 0,
  maxValue1: 10,
  baseValue2: 0,
  maxValue2: 5,
};

export const bagsSlice = createSlice({
  name: 'bags',
  initialState,
  reducers: {
    setBagsForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setBagsBaseValue1: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'bags', value: state.baseValue1 });
    },
    setBagsMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setBagsBaseValue2: (state, action: PayloadAction<number>) => {
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
        name: 'bags',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
    setBagsMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setBagsBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'bags', value: state.baseValue1 });
    },
    setBagsBaseValue2ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'bags',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
  },
});

export default bagsSlice.reducer;
export const {
  setBagsBaseValue1,
  setBagsMaxValue1,
  setBagsBaseValue2,
  setBagsMaxValue2,
  setBagsBaseValue1ByInput,
  setBagsBaseValue2ByInput,
  setBagsForFirstTime,
} = bagsSlice.actions;
