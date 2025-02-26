import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface themeState {
  theme: any;
}

const initialState: themeState = {
  theme: [],
};

export const themeSlice = createSlice({
  name: 'theme',
  initialState,
  reducers: {
    setTheme: (state, action: PayloadAction<any>) => {
      state.theme = action.payload;
    },
  },
});

export default themeSlice.reducer;
export const { setTheme } = themeSlice.actions;
