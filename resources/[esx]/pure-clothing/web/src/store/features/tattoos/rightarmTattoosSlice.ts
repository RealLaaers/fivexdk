import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface rightarmTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: rightarmTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const rightarmTattooSlice = createSlice({
  name: 'rightarmTattoos',
  initialState,
  reducers: {
    setrightarmTattooAmountOfTattoos: (
      state,
      action: PayloadAction<number>
    ) => {
      state.amountOfTattoos = action.payload;
    },
    setrightarmTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', {
        type: 'rightarm',
        tattoos: state.selectedTattoos,
      });
    },
  },
});

export default rightarmTattooSlice.reducer;
export const {
  setrightarmTattooAmountOfTattoos,
  setrightarmTattooTattoosArray,
  setSelectedTattoos,
} = rightarmTattooSlice.actions;
