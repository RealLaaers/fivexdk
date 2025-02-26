import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface EyebrowState {
  depth: number;
  height: number;
}

const initialState: EyebrowState = {
  depth: 50,
  height: 50,
};

export const eyebrowSlice = createSlice({
  name: 'eyebrow',
  initialState,
  reducers: {
    setDepth: (state, action: PayloadAction<number>) => {
      state.depth = action.payload;
      sendNui('setAppearance', {
        name: 'eyebrow',
        value: state.depth,
        type: 'depth',
      });
    },
    setHeight: (state, action: PayloadAction<number>) => {
      state.height = action.payload;
      sendNui('setAppearance', {
        name: 'eyebrow',
        value: state.height,
        type: 'height',
      });
    },
    setDefaultValues: (state) => {
      state.depth = 50;
      state.height = 50;
      sendNui('setAppearance', {
        name: 'eyebrow',
        value: state.depth,
        type: 'depth',
      });
      sendNui('setAppearance', {
        name: 'eyebrow',
        value: state.height,
        type: 'height',
      });
    },
  },
});

export default eyebrowSlice.reducer;
export const { setDepth, setHeight, setDefaultValues } = eyebrowSlice.actions;
