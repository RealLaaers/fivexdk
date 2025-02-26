import { configureStore } from '@reduxjs/toolkit';
import { useDispatch, useSelector, TypedUseSelectorHook } from 'react-redux';
import { currentClothingPageSlice } from './features/pages/currentClothingPageSlice';
import { currentCreateCharPageSlice } from './features/pages/currentCreateCharPageSlice';
import { jacketSlice } from './features/clothing/jacketSlice';
import { undershirtSlice } from './features/clothing/undershirtSlice';
import { armsSlice } from './features/clothing/armsSlice';
import { bagsSlice } from './features/clothing/bagsSlice';
import { braceletsSlice } from './features/clothing/braceletsSlice';
import { chainsSlice } from './features/clothing/chainsSlice';
import { decalsSlice } from './features/clothing/decalsSlice';
import { glassesSlice } from './features/clothing/glassesSlice';
import { helmetsSlice } from './features/clothing/helmetsSlice';
import { masksSlice } from './features/clothing/masksSlice';
import { pantsSlice } from './features/clothing/pantsSlice';
import { shoesSlice } from './features/clothing/shoesSlice';
import { vestsSlice } from './features/clothing/vestsSlice';
import { watchesSlice } from './features/clothing/watchesSlice';
import { earringsSlice } from './features/clothing/earringsSlice';
import { currentPageSlice } from './features/pages/currentPageSlice';
import { hairSlice } from './features/hair/hairSlice';
import { ageSlice } from './features/hair/ageSlice';
import { beardSlice } from './features/hair/beardSlice';
import { blemishesSlice } from './features/hair/blemishesSlice';
import { blushSlice } from './features/hair/blushSlice';
import { bodySlice } from './features/hair/bodySlice';
import { chestSlice } from './features/hair/chestSlice';
import { eyebrowsSlice } from './features/hair/eyebrowsSlice';
import { lipstickSlice } from './features/hair/lipstickSlice';
import { frecklesSlice } from './features/hair/frecklesSlice';
import { makeupSlice } from './features/hair/makeupSlice';
import { complextionSlice } from './features/hair/complextionSlice';
import { sundamageSlice } from './features/hair/sundamageSlice';
import { headTattooSlice } from './features/tattoos/headTattoosSlice';
import { leftarmTattooSlice } from './features/tattoos/leftarmTattoosSlice';
import { rightarmTattooSlice } from './features/tattoos/rightarmTattoosSlice';
import { leftlegTattooSlice } from './features/tattoos/leftlegTattoosSlice';
import { rightlegTattooSlice } from './features/tattoos/rightlegTattoosSlice';
import { chestTattoosSlice } from './features/tattoos/chestTattoosSlice';
import { parentsSlice } from './features/createChar/parentsSlice';
import { cheekSlice } from './features/createChar/cheekSlice';
import { chinSlice } from './features/createChar/chinSlice';
import { eyesSlice } from './features/createChar/eyesSlice';
import { eyebrowSlice } from './features/createChar/eyebrowSlice';
import { jawSlice } from './features/createChar/jawSlice';
import { lipSlice } from './features/createChar/lipSlice';
import { neckSlice } from './features/createChar/neckSlice';
import { noseSlice } from './features/createChar/noseSlice';
import { pedsSlice } from './features/createChar/pedsSlice';
import { popupPageSlice } from './features/popup/popupSlice';
import { outfitSlice } from './features/outfits/outfitSlice';
import { configSlice } from './features/config/configSlice';
import { themeSlice } from './features/config/themeSlice';

export const clothingStore = configureStore({
  reducer: {
    jacket: jacketSlice.reducer,
    undershirt: undershirtSlice.reducer,
    arms: armsSlice.reducer,
    bags: bagsSlice.reducer,
    bracelets: braceletsSlice.reducer,
    chains: chainsSlice.reducer,
    decals: decalsSlice.reducer,
    glasses: glassesSlice.reducer,
    helmets: helmetsSlice.reducer,
    masks: masksSlice.reducer,
    pants: pantsSlice.reducer,
    shoes: shoesSlice.reducer,
    vests: vestsSlice.reducer,
    watches: watchesSlice.reducer,
    earrings: earringsSlice.reducer,
    currentPage: currentPageSlice.reducer,
    currentClothingPage: currentClothingPageSlice.reducer,
    currentCreateCharPage: currentCreateCharPageSlice.reducer,
    hair: hairSlice.reducer,
    age: ageSlice.reducer,
    beard: beardSlice.reducer,
    blemishes: blemishesSlice.reducer,
    blush: blushSlice.reducer,
    body: bodySlice.reducer,
    chest: chestSlice.reducer,
    eyebrows: eyebrowsSlice.reducer,
    lipstick: lipstickSlice.reducer,
    freckles: frecklesSlice.reducer,
    makeup: makeupSlice.reducer,
    complextion: complextionSlice.reducer,
    sundamage: sundamageSlice.reducer,
    headTattoos: headTattooSlice.reducer,
    leftarmTattoos: leftarmTattooSlice.reducer,
    rightarmTattoos: rightarmTattooSlice.reducer,
    leftlegTattoos: leftlegTattooSlice.reducer,
    rightlegTattoos: rightlegTattooSlice.reducer,
    chestTattoos: chestTattoosSlice.reducer,
    parents: parentsSlice.reducer,
    cheek: cheekSlice.reducer,
    chin: chinSlice.reducer,
    eyes: eyesSlice.reducer,
    eyebrow: eyebrowSlice.reducer,
    jaw: jawSlice.reducer,
    lip: lipSlice.reducer,
    neck: neckSlice.reducer,
    nose: noseSlice.reducer,
    peds: pedsSlice.reducer,
    togglePopup: popupPageSlice.reducer,
    outfit: outfitSlice.reducer,
    config: configSlice.reducer,
    theme: themeSlice.reducer,
  },
});

export const useAppDistpatch: () => typeof clothingStore.dispatch = useDispatch;
export const useAppSelector: TypedUseSelectorHook<
  ReturnType<typeof clothingStore.getState>
> = useSelector;
