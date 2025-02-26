import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface ShoesState {
  baseValue1: number;
  maxValue1: number;
  baseValue2: number;
  maxValue2: number;
}

const initialState: ShoesState = {
  baseValue1: 0,
  maxValue1: 10,
  baseValue2: 0,
  maxValue2: 5,
};

export const shoesSlice = createSlice({
  name: 'shoes',
  initialState,
  reducers: {
    setShoesForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setShoesBaseValue1: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'shoes', value: state.baseValue1 });
    },
    setShoesMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setShoesBaseValue2: (state, action: PayloadAction<number>) => {
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
        name: 'shoes',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
    setShoesMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setShoesBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'shoes', value: state.baseValue1 });
    },
    setShoesBaseValue2ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'shoes',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
  },
});

export default shoesSlice.reducer;
export const {
  setShoesBaseValue1,
  setShoesMaxValue1,
  setShoesBaseValue2,
  setShoesMaxValue2,
  setShoesBaseValue1ByInput,
  setShoesBaseValue2ByInput,
  setShoesForFirstTime,
} = shoesSlice.actions;
