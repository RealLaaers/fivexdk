import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface outfit {
  arms: [number, number];
  bags: [number, number];
  bracelets: [number, number];
  chains: [number, number];
  decals: [number, number];
  earrings: [number, number];
  glasses: [number, number];
  helmets: [number, number];
  jacket: [number, number];
  masks: [number, number];
  pants: [number, number];
  shoes: [number, number];
  undershirt: [number, number];
  vests: [number, number];
  watches: [number, number];
}

export interface outfitState {
  currentOutfits: Array<{
    name: string;
    id: number;
    outfit: Array<outfit>;
    uniqueOutfitid: string;
    type: string;
  }>;
  configOutfits: Array<{
    name: string;
    id: number;
    outfit: Array<outfit>;
    uniqueOutfitid: string;
    type: string;
  }>;
}

const initialState: outfitState = {
  currentOutfits: [
    // {
    //   name: 'Casual',
    //   id: 1,
    //   outfit: [
    //     {
    //       arms: [0, 0],
    //       bags: [0, 0],
    //       bracelets: [0, 0],
    //       chains: [0, 0],
    //       decals: [0, 0],
    //       earrings: [0, 0],
    //       glasses: [0, 0],
    //       helmets: [0, 0],
    //       jacket: [0, 0],
    //       masks: [0, 0],
    //       pants: [0, 0],
    //       shoes: [0, 0],
    //       undershirt: [0, 0],
    //       vests: [0, 0],
    //       watches: [0, 0],
    //     },
    //   ],
    //   uniqueOutfitid: 'CITIZEN-1',
    // },
  ],
  configOutfits: [
    // {
    //   name: 'Police Officer',
    //   id: 1,
    //   outfit: [
    //     {
    //       arms: [0, 0],
    //       bags: [0, 0],
    //       bracelets: [0, 0],
    //       chains: [0, 0],
    //       decals: [0, 0],
    //       earrings: [0, 0],
    //       glasses: [0, 0],
    //       helmets: [0, 0],
    //       jacket: [0, 0],
    //       masks: [0, 0],
    //       pants: [0, 0],
    //       shoes: [0, 0],
    //       undershirt: [0, 0],
    //       vests: [0, 0],
    //       watches: [0, 0],
    //     },
    //   ],
    // },
    // {
    //   name: 'Police Officer 2',
    //   id: 2,
    //   outfit: [
    //     {
    //       arms: [0, 0],
    //       bags: [0, 0],
    //       bracelets: [0, 0],
    //       chains: [0, 0],
    //       decals: [0, 0],
    //       earrings: [0, 0],
    //       glasses: [0, 0],
    //       helmets: [0, 0],
    //       jacket: [0, 0],
    //       masks: [0, 0],
    //       pants: [0, 0],
    //       shoes: [0, 0],
    //       undershirt: [0, 0],
    //       vests: [0, 0],
    //       watches: [0, 0],
    //     },
    //   ],
    // },
  ],
};

export const outfitSlice = createSlice({
  name: 'outfit',
  initialState,
  reducers: {
    setCurrentOutfits: (state, action: PayloadAction<[]>) => {
      state.currentOutfits = action.payload;
    },
    setConfigOutfits: (state, action: PayloadAction<[]>) => {
      state.configOutfits = action.payload;
    },
  },
});

export default outfitSlice.reducer;
export const { setCurrentOutfits, setConfigOutfits } = outfitSlice.actions;
