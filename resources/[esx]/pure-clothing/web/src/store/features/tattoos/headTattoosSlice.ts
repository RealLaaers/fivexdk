import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface HeadTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: HeadTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const headTattooSlice = createSlice({
  name: 'headTattoos',
  initialState,
  reducers: {
    setHeadTattooAmountOfTattoos: (state, action: PayloadAction<number>) => {
      state.amountOfTattoos = action.payload;
    },
    setHeadTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', { type: 'head', tattoos: state.selectedTattoos });
    },
  },
});

export default headTattooSlice.reducer;
export const {
  setHeadTattooAmountOfTattoos,
  setHeadTattooTattoosArray,
  setSelectedTattoos,
} = headTattooSlice.actions;
