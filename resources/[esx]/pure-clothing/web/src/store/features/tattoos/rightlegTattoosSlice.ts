import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface rightlegTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: rightlegTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const rightlegTattooSlice = createSlice({
  name: 'rightlegTattoos',
  initialState,
  reducers: {
    setrightlegTattooAmountOfTattoos: (
      state,
      action: PayloadAction<number>
    ) => {
      state.amountOfTattoos = action.payload;
    },
    setrightlegTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', {
        type: 'rightleg',
        tattoos: state.selectedTattoos,
      });
    },
  },
});

export default rightlegTattooSlice.reducer;
export const {
  setrightlegTattooAmountOfTattoos,
  setrightlegTattooTattoosArray,
  setSelectedTattoos,
} = rightlegTattooSlice.actions;
