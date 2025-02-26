import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface leftlegTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: leftlegTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const leftlegTattooSlice = createSlice({
  name: 'leftlegTattoos',
  initialState,
  reducers: {
    setleftlegTattooAmountOfTattoos: (state, action: PayloadAction<number>) => {
      state.amountOfTattoos = action.payload;
    },
    setleftlegTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', {
        type: 'leftleg',
        tattoos: state.selectedTattoos,
      });
    },
  },
});

export default leftlegTattooSlice.reducer;
export const {
  setleftlegTattooAmountOfTattoos,
  setleftlegTattooTattoosArray,
  setSelectedTattoos,
} = leftlegTattooSlice.actions;
