import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface NoseState {
  depth: number;
  length: number;
  shape: number;
  hole: number;
  tip: number;
}

const initialState: NoseState = {
  depth: 50,
  length: 50,
  shape: 50,
  hole: 50,
  tip: 50,
};

export const chinSlice = createSlice({
  name: 'chin',
  initialState,
  reducers: {
    setDepth: (state, action: PayloadAction<number>) => {
      state.depth = action.payload;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.depth,
        type: 'depth',
      });
    },
    setLength: (state, action: PayloadAction<number>) => {
      state.length = action.payload;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.length,
        type: 'length',
      });
    },
    setShape: (state, action: PayloadAction<number>) => {
      state.shape = action.payload;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.shape,
        type: 'width',
      });
    },
    setHole: (state, action: PayloadAction<number>) => {
      state.hole = action.payload;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.hole,
        type: 'hole',
      });
    },
    setTip: (state, action: PayloadAction<number>) => {
      state.tip = action.payload;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.tip,
        type: 'tip',
      });
    },
    setDefaultValues: (state) => {
      state.depth = 50;
      state.length = 50;
      state.shape = 50;
      state.hole = 50;
      state.tip = 50;
      sendNui('setAppearance', {
        name: 'chin',
        value: state.depth,
        type: 'depth',
      });
      sendNui('setAppearance', {
        name: 'chin',
        value: state.length,
        type: 'length',
      });
      sendNui('setAppearance', {
        name: 'chin',
        value: state.shape,
        type: 'width',
      });
      sendNui('setAppearance', {
        name: 'chin',
        value: state.hole,
        type: 'hole',
      });
      sendNui('setAppearance', {
        name: 'chin',
        value: state.tip,
        type: 'tip',
      });
    },
  },
});

export default chinSlice.reducer;
export const {
  setDepth,
  setLength,
  setShape,
  setHole,
  setTip,
  setDefaultValues,
} = chinSlice.actions;
