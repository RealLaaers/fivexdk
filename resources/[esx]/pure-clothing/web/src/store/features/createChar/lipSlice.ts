import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface lipState {
  thickness: number;
}

const initialState: lipState = {
  thickness: 50,
};

export const lipSlice = createSlice({
  name: 'lip',
  initialState,
  reducers: {
    setThickness: (state, action: PayloadAction<number>) => {
      state.thickness = action.payload;
      sendNui('setAppearance', {
        name: 'lip',
        value: state.thickness,
        type: 'thickness',
      });
    },
    setDefaultValues: (state) => {
      state.thickness = 50;
      sendNui('setAppearance', {
        name: 'lip',
        value: state.thickness,
        type: 'thickness',
      });
    },
  },
});

export default lipSlice.reducer;
export const { setThickness, setDefaultValues } = lipSlice.actions;
