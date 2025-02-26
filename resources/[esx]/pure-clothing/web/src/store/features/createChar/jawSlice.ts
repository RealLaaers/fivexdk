import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface jawState {
  width: number;
  shape: number;
}

const initialState: jawState = {
  width: 50,
  shape: 50,
};

export const jawSlice = createSlice({
  name: 'jaw',
  initialState,
  reducers: {
    setWidth: (state, action: PayloadAction<number>) => {
      state.width = action.payload;
      sendNui('setAppearance', {
        name: 'jaw',
        value: state.width,
        type: 'width',
      });
    },
    setShape: (state, action: PayloadAction<number>) => {
      state.shape = action.payload;
      sendNui('setAppearance', {
        name: 'jaw',
        value: state.shape,
        type: 'shape',
      });
    },
    setDefaultValues: (state) => {
      state.width = 50;
      state.shape = 50;
      sendNui('setAppearance', {
        name: 'jaw',
        value: state.width,
        type: 'width',
      });
      sendNui('setAppearance', {
        name: 'jaw',
        value: state.shape,
        type: 'shape',
      });
    },
  },
});

export default jawSlice.reducer;
export const { setWidth, setShape, setDefaultValues } = jawSlice.actions;
