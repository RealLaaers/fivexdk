import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface pedsState {
  currentPed: string;
}

const initialState: pedsState = {
  currentPed: 'mp_m_freemode_01',
};

export const pedsSlice = createSlice({
  name: 'peds',
  initialState,
  reducers: {
    setCurrentPed: (state, action: PayloadAction<string>) => {
      if (action.payload === '') {
        state.currentPed = 'mp_m_freemode_01';
      } else {
        state.currentPed = action.payload;
      }
      sendNui('setPed', { model: state.currentPed });
    },
    setPedOnFirstLoad: (state, action: PayloadAction<string>) => {
      state.currentPed = action.payload;
    },
  },
});

export default pedsSlice.reducer;
export const { setCurrentPed, setPedOnFirstLoad } = pedsSlice.actions;
