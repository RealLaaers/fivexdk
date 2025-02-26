import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface configState {
  config: any;
  disabledMenusForPed: boolean;
  language: any;
}

const initialState: configState = {
  config: [],
  disabledMenusForPed: false,
  language: [],
};

export const configSlice = createSlice({
  name: 'config',
  initialState,
  reducers: {
    setConfig: (state, action: PayloadAction<any>) => {
      state.config = action.payload;
    },
    setDisabledMenusForPed: (state, action: PayloadAction<boolean>) => {
      state.disabledMenusForPed = action.payload;
    },
    setLanguage: (state, action: PayloadAction<any>) => {
      state.language = action.payload;
    },
  },
});

export default configSlice.reducer;
export const { setConfig, setDisabledMenusForPed, setLanguage } =
  configSlice.actions;
