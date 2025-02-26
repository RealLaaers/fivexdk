import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface NoseState {
  width: number;
  peak: number;
  length: number;
  curveness: number;
  tip: number;
  twist: number;
}

const initialState: NoseState = {
  width: 50,
  peak: 50,
  length: 50,
  curveness: 50,
  tip: 50,
  twist: 50,
};

export const noseSlice = createSlice({
  name: 'nose',
  initialState,
  reducers: {
    setWidth: (state, action: PayloadAction<number>) => {
      state.width = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.width,
        type: 'width',
      });
    },
    setPeak: (state, action: PayloadAction<number>) => {
      state.peak = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.peak,
        type: 'peak',
      });
    },
    setLength: (state, action: PayloadAction<number>) => {
      state.length = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.length,
        type: 'length',
      });
    },
    setCurveness: (state, action: PayloadAction<number>) => {
      state.curveness = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.curveness,
        type: 'curveness',
      });
    },
    setTip: (state, action: PayloadAction<number>) => {
      state.tip = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.tip,
        type: 'tip',
      });
    },
    setTwist: (state, action: PayloadAction<number>) => {
      state.twist = action.payload;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.twist,
        type: 'twist',
      });
    },
    setDefaultValues: (state) => {
      state.width = 50;
      state.peak = 50;
      state.length = 50;
      state.curveness = 50;
      state.tip = 50;
      state.twist = 50;
      sendNui('setAppearance', {
        name: 'nose',
        value: state.width,
        type: 'width',
      });
      sendNui('setAppearance', {
        name: 'nose',
        value: state.peak,
        type: 'peak',
      });
      sendNui('setAppearance', {
        name: 'nose',
        value: state.length,
        type: 'length',
      });
      sendNui('setAppearance', {
        name: 'nose',
        value: state.curveness,
        type: 'curveness',
      });
      sendNui('setAppearance', {
        name: 'nose',
        value: state.tip,
        type: 'tip',
      });
      sendNui('setAppearance', {
        name: 'nose',
        value: state.twist,
        type: 'twist',
      });
    },
  },
});

export default noseSlice.reducer;
export const {
  setWidth,
  setPeak,
  setLength,
  setCurveness,
  setTip,
  setTwist,
  setDefaultValues,
} = noseSlice.actions;
