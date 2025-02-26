import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface leftarmTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: leftarmTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const leftarmTattooSlice = createSlice({
  name: 'leftarmTattoos',
  initialState,
  reducers: {
    setleftarmTattooAmountOfTattoos: (state, action: PayloadAction<number>) => {
      state.amountOfTattoos = action.payload;
    },
    setleftarmTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', {
        type: 'leftarm',
        tattoos: state.selectedTattoos,
      });
    },
  },
});

export default leftarmTattooSlice.reducer;
export const {
  setleftarmTattooAmountOfTattoos,
  setleftarmTattooTattoosArray,
  setSelectedTattoos,
} = leftarmTattooSlice.actions;
