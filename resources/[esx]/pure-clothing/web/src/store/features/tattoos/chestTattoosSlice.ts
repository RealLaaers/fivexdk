import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface chestTattooState {
  amountOfTattoos: number;
  tattoosArray: any;
  selectedTattoos: any;
}

const initialState: chestTattooState = {
  amountOfTattoos: 20,
  tattoosArray: [],
  selectedTattoos: [],
};

export const chestTattoosSlice = createSlice({
  name: 'chestTattoos',
  initialState,
  reducers: {
    setchestTattooAmountOfTattoos: (state, action: PayloadAction<number>) => {
      state.amountOfTattoos = action.payload;
    },
    setchestTattooTattoosArray: (state, action: PayloadAction<any>) => {
      state.tattoosArray = action.payload;
    },
    setSelectedTattoos: (state, action: PayloadAction<any>) => {
      state.selectedTattoos = action.payload;
      sendNui('setTattoos', { type: 'torso', tattoos: state.selectedTattoos });
    },
  },
});

export default chestTattoosSlice.reducer;
export const {
  setchestTattooAmountOfTattoos,
  setchestTattooTattoosArray,
  setSelectedTattoos,
} = chestTattoosSlice.actions;
