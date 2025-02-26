import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface eyesState {
  opening: number;
  eyeColour: number;
}

const initialState: eyesState = {
  opening: 50,
  eyeColour: 0,
};

export const eyesSlice = createSlice({
  name: 'eyes',
  initialState,
  reducers: {
    setOpening: (state, action: PayloadAction<number>) => {
      state.opening = action.payload;
      sendNui('setAppearance', {
        name: 'eyes',
        value: state.opening,
        type: 'opening',
      });
    },
    setEyeColour: (state, action: PayloadAction<number>) => {
      state.eyeColour = action.payload;
      sendNui('setEyeColour', state.eyeColour);
    },
    setDefaultValues: (state) => {
      state.opening = 50;
      sendNui('setAppearance', {
        name: 'eyes',
        value: state.opening,
        type: 'opening',
      });
      sendNui('setEyeColour', state.eyeColour);
    },
  },
});

export default eyesSlice.reducer;
export const { setOpening, setDefaultValues, setEyeColour } = eyesSlice.actions;
