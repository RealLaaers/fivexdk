import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface currentPageState {
  currentPage: string;
  activeDiv: number;
}
const initialState: currentPageState = {
  currentPage: 'createCharacter',
  activeDiv: 0,
};

export const currentPageSlice = createSlice({
  name: 'currentPage',
  initialState,
  reducers: {
    setCurrentPage: (state, action: PayloadAction<string>) => {
      state.currentPage = action.payload;
    },
    setActiveDiv: (state, action: PayloadAction<number>) => {
      state.activeDiv = action.payload;
    },
  },
});

export default currentPageSlice.reducer;
export const { setCurrentPage, setActiveDiv } = currentPageSlice.actions;
