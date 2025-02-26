import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface currentClothingPageState {
  currentPage: string;
}
const initialState: currentClothingPageState = {
  currentPage: 'clothing',
};

export const currentClothingPageSlice = createSlice({
  name: 'currentPage',
  initialState,
  reducers: {
    setCurrentClothingPage: (state, action: PayloadAction<string>) => {
      state.currentPage = action.payload;
    },
  },
});

export default currentClothingPageSlice.reducer;
export const { setCurrentClothingPage } = currentClothingPageSlice.actions;
