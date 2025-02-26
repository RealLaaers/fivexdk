import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface currentCreateCharPageSlice {
  currentPage: string;
}
const initialState: currentCreateCharPageSlice = {
  currentPage: 'faceStructure',
};

export const currentCreateCharPageSlice = createSlice({
  name: 'currentPage',
  initialState,
  reducers: {
    setCurrentCreateCharPage: (state, action: PayloadAction<string>) => {
      state.currentPage = action.payload;
    },
  },
});

export default currentCreateCharPageSlice.reducer;
export const { setCurrentCreateCharPage } = currentCreateCharPageSlice.actions;
