import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface popupPageState {
  showPopup: boolean;
  popupPage: string;
}
const initialState: popupPageState = {
  showPopup: false,
  popupPage: 'info',
};

export const popupPageSlice = createSlice({
  name: 'currentPage',
  initialState,
  reducers: {
    togglePopup: (state, action: PayloadAction<boolean>) => {
      state.showPopup = action.payload;
    },
    popupPage: (state, action: PayloadAction<string>) => {
      state.popupPage = action.payload;
    },
  },
});

export default popupPageSlice.reducer;
export const { togglePopup, popupPage } = popupPageSlice.actions;
