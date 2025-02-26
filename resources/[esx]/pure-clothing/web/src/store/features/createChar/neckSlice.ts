import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface neckState {
  thickness: number;
}

const initialState: neckState = {
  thickness: 50,
};

export const neckSlice = createSlice({
  name: 'neck',
  initialState,
  reducers: {
    setThickness: (state, action: PayloadAction<number>) => {
      state.thickness = action.payload;
      sendNui('setAppearance', {
        name: 'neck',
        value: state.thickness,
        type: 'thickness',
      });
    },
    setDefaultValues: (state) => {
      state.thickness = 50;
      sendNui('setAppearance', {
        name: 'neck',
        value: state.thickness,
        type: 'thickness',
      });
    },
  },
});

export default neckSlice.reducer;
export const { setThickness, setDefaultValues } = neckSlice.actions;
