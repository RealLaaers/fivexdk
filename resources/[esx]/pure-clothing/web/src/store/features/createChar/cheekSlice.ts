import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface cheekState {
  depth: number;
  height: number;
  width: number;
}

const initialState: cheekState = {
  depth: 50,
  height: 50,
  width: 50,
};

export const cheekSlice = createSlice({
  name: 'cheek',
  initialState,
  reducers: {
    setDepth: (state, action: PayloadAction<number>) => {
      state.depth = action.payload;
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.depth,
        type: 'depth',
      });
    },
    setHeight: (state, action: PayloadAction<number>) => {
      state.height = action.payload;
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.height,
        type: 'height',
      });
    },
    setWidth: (state, action: PayloadAction<number>) => {
      state.width = action.payload;
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.width,
        type: 'width',
      });
    },
    setDefaultValues: (state) => {
      state.depth = 50;
      state.height = 50;
      state.width = 50;
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.width,
        type: 'width',
      });
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.height,
        type: 'height',
      });
      sendNui('setAppearance', {
        name: 'cheek',
        value: state.depth,
        type: 'depth',
      });
    },
  },
});

export default cheekSlice.reducer;
export const { setDepth, setHeight, setWidth, setDefaultValues } =
  cheekSlice.actions;
