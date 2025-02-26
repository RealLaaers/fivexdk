import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface UndershirtState {
  baseValue1: number;
  maxValue1: number;
  baseValue2: number;
  maxValue2: number;
}

const initialState: UndershirtState = {
  baseValue1: 0,
  maxValue1: 10,
  baseValue2: 0,
  maxValue2: 5,
};

export const undershirtSlice = createSlice({
  name: 'jacket',
  initialState,
  reducers: {
    setUndershirtForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setUndershirtBaseValue1: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'undershirt', value: state.baseValue1 });
    },
    setUndershirtMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setUndershirtBaseValue2: (state, action: PayloadAction<number>) => {
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
        name: 'undershirt',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
    setUndershirtMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setUndershirtBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'undershirt', value: state.baseValue1 });
    },
    setUndershirtBaseValue2ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'undershirt',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
  },
});

export default undershirtSlice.reducer;
export const {
  setUndershirtBaseValue1,
  setUndershirtMaxValue1,
  setUndershirtBaseValue2,
  setUndershirtMaxValue2,
  setUndershirtBaseValue1ByInput,
  setUndershirtBaseValue2ByInput,
  setUndershirtForFirstTime,
} = undershirtSlice.actions;
