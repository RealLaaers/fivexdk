import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface VestsState {
  baseValue1: number;
  maxValue1: number;
  baseValue2: number;
  maxValue2: number;
}

const initialState: VestsState = {
  baseValue1: 0,
  maxValue1: 10,
  baseValue2: 0,
  maxValue2: 5,
};

export const vestsSlice = createSlice({
  name: 'vests',
  initialState,
  reducers: {
    setVestsForFirstTime: (state, action: PayloadAction<number>) => {
      state.baseValue1 = action.payload;
    },
    setVestsBaseValue1: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'vests', value: state.baseValue1 });
    },
    setVestsMaxValue1: (state, action: PayloadAction<number>) => {
      state.maxValue1 = action.payload;
    },
    setVestsBaseValue2: (state, action: PayloadAction<number>) => {
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
        name: 'vests',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
    setVestsMaxValue2: (state, action: PayloadAction<number>) => {
      state.maxValue2 = action.payload;
    },
    setVestsBaseValue1ByInput: (state, action: PayloadAction<number>) => {
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
      sendNui('setAppearance', { name: 'vests', value: state.baseValue1 });
    },
    setVestsBaseValue2ByInput: (state, action: PayloadAction<number>) => {
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
        name: 'vests',
        value1: state.baseValue1,
        value2: state.baseValue2,
      });
    },
  },
});

export default vestsSlice.reducer;
export const {
  setVestsBaseValue1,
  setVestsMaxValue1,
  setVestsBaseValue2,
  setVestsMaxValue2,
  setVestsBaseValue1ByInput,
  setVestsBaseValue2ByInput,
  setVestsForFirstTime,
} = vestsSlice.actions;
