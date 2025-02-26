import React, { useEffect, Suspense, useState, useMemo, lazy } from 'react';
import { useAppSelector, useAppDistpatch } from './store/store';
import Draggable from 'react-draggable';
import { useNuiEvent } from './hooks/useNuiEvent';
import { getThemeVariables } from './utils/getThemeVariables';
import { sendNui } from './utils/sendNui';
import {
  setActiveDiv,
  setCurrentPage,
} from './store/features/pages/currentPageSlice';
import {
  setDefaultValues as setDefaultValuesParent,
  setFatherValue,
  setGender,
  setMotherValue,
  setSimilarity,
  setSkinColour,
} from './store/features/createChar/parentsSlice';
import { setDefaultValues as setDefaultValuesCheek } from './store/features/createChar/cheekSlice';
import { setDefaultValues as setDefaultValuesChin } from './store/features/createChar/chinSlice';
import { setDefaultValues as setDefaultValuesEyebrow } from './store/features/createChar/eyebrowSlice';
import { setDefaultValues as setDefaultValuesEyes } from './store/features/createChar/eyesSlice';
import { setDefaultValues as setDefaultValuesJaw } from './store/features/createChar/jawSlice';
import { setDefaultValues as setDefaultValuesLip } from './store/features/createChar/lipSlice';
import { setDefaultValues as setDefaultValuesNeck } from './store/features/createChar/neckSlice';
import { setDefaultValues as setDefaultValuesNose } from './store/features/createChar/noseSlice';
import {
  setArmsBaseValue1,
  setArmsBaseValue2,
  setArmsMaxValue1,
  setArmsMaxValue2,
  setArmsForFirstTime,
} from './store/features/clothing/armsSlice';
import {
  setBagsBaseValue1,
  setBagsBaseValue2,
  setBagsMaxValue1,
  setBagsMaxValue2,
  setBagsForFirstTime,
} from './store/features/clothing/bagsSlice';
import {
  setBraceletsBaseValue1,
  setBraceletsBaseValue2,
  setBraceletsMaxValue1,
  setBraceletsMaxValue2,
  setBraceletsForFirstTime,
} from './store/features/clothing/braceletsSlice';
import {
  setChainsBaseValue1,
  setChainsBaseValue2,
  setChainsMaxValue1,
  setChainsMaxValue2,
  setChainsForFirstTime,
} from './store/features/clothing/chainsSlice';
import {
  setDecalsBaseValue1,
  setDecalsBaseValue2,
  setDecalsMaxValue1,
  setDecalsMaxValue2,
  setDecalsForFirstTime,
} from './store/features/clothing/decalsSlice';
import {
  setEarringsBaseValue1,
  setEarringsBaseValue2,
  setEarringsMaxValue1,
  setEarringsMaxValue2,
  setEarringsForFirstTime,
} from './store/features/clothing/earringsSlice';
import {
  setGlassesBaseValue1,
  setGlassesBaseValue2,
  setGlassesMaxValue1,
  setGlassesMaxValue2,
  setGlassesForFirstTime,
} from './store/features/clothing/glassesSlice';
import {
  setHelmetsBaseValue1,
  setHelmetsBaseValue2,
  setHelmetsMaxValue1,
  setHelmetsMaxValue2,
  setHelmetsForFirstTime,
} from './store/features/clothing/helmetsSlice';
import {
  setJacketBaseValue1,
  setJacketBaseValue2,
  setJacketMaxValue1,
  setJacketMaxValue2,
  setJacketForFirstTime,
} from './store/features/clothing/jacketSlice';
import {
  setMasksBaseValue1,
  setMasksBaseValue2,
  setMasksMaxValue1,
  setMasksMaxValue2,
  setMasksForFirstTime,
} from './store/features/clothing/masksSlice';
import {
  setPantsBaseValue1,
  setPantsBaseValue2,
  setPantsMaxValue1,
  setPantsMaxValue2,
  setPantsForFirstTime,
} from './store/features/clothing/pantsSlice';
import {
  setShoesBaseValue1,
  setShoesBaseValue2,
  setShoesMaxValue1,
  setShoesMaxValue2,
  setShoesForFirstTime,
} from './store/features/clothing/shoesSlice';
import {
  setUndershirtBaseValue1,
  setUndershirtBaseValue2,
  setUndershirtMaxValue1,
  setUndershirtMaxValue2,
  setUndershirtForFirstTime,
} from './store/features/clothing/undershirtSlice';
import {
  setVestsBaseValue1,
  setVestsBaseValue2,
  setVestsMaxValue1,
  setVestsMaxValue2,
  setVestsForFirstTime,
} from './store/features/clothing/vestsSlice';
import {
  setWatchesBaseValue1,
  setWatchesBaseValue2,
  setWatchesMaxValue1,
  setWatchesMaxValue2,
  setWatchesForFirstTime,
} from './store/features/clothing/watchesSlice';
import {
  setHairMaxValue1,
  setHairMaxValue2,
  setHairBaseValue1,
  setHairBaseValue2,
  setHairColourID1,
  setHairColourID2,
  setHairForFirstTime,
} from './store/features/hair/hairSlice';
import {
  setAgeBaseValue1,
  setAgeMaxValue1,
  setAgeOpacity,
  setAgeForFirstTime,
} from './store/features/hair/ageSlice';
import {
  setBeardBaseValue1,
  setBeardMaxValue1,
  setBeardColourID1,
  setBeardOpacity,
  setBeardForFirstTime,
} from './store/features/hair/beardSlice';
import {
  setBlemishesMaxValue1,
  setBlemishesBaseValue1,
  setBlemishesOpacity,
  setBlemishesForFirstTime,
} from './store/features/hair/blemishesSlice';
import {
  setBlushMaxValue1,
  setBlushBaseValue1,
  setBlushColourID1,
  setBlushOpacity,
  setBlushForFirstTime,
} from './store/features/hair/blushSlice';
import {
  setBodyMaxValue1,
  setBodyBaseValue1,
  setBodyOpacity,
  setBodyForFirstTime,
} from './store/features/hair/bodySlice';
import {
  setChestMaxValue1,
  setChestBaseValue1,
  setChestColourID1,
  setChestOpacity,
  setChestForFirstTime,
} from './store/features/hair/chestSlice';
import {
  setEyebrowsMaxValue1,
  setEyebrowsBaseValue1,
  setEyebrowsColourID1,
  setEyebrowsOpacity,
  setEyebrowsForFirstTime,
} from './store/features/hair/eyebrowsSlice';
import {
  setLipstickMaxValue1,
  setLipstickBaseValue1,
  setLipstickColourID1,
  setLipstickOpacity,
  setLipstickForFirstTime,
} from './store/features/hair/lipstickSlice';
import {
  setFrecklesMaxValue1,
  setFrecklesBaseValue1,
  setFrecklesOpacity,
  setFrecklesForFirstTime,
} from './store/features/hair/frecklesSlice';
import {
  setMakeupMaxValue1,
  setMakeupBaseValue1,
  setMakeupColourID1,
  setMakeupOpacity,
  setMakeupForFirstTime,
} from './store/features/hair/makeupSlice';
import {
  setComplextionMaxValue1,
  setComplextionBaseValue1,
  setComplextionOpacity,
  setComplextionForFirstTime,
} from './store/features/hair/complextionSlice';
import {
  setSundamageMaxValue1,
  setSundamageBaseValue1,
  setSundamageOpacity,
  setSundamageForFirstTime,
} from './store/features/hair/sundamageSlice';
import { setPedOnFirstLoad } from './store/features/createChar/pedsSlice';
import {
  setWidth as setNoseWidth,
  setPeak as setNosePeak,
  setLength as setNoseLength,
  setCurveness as setNoseCurveness,
  setTip as setNoseTip,
  setTwist as setNoseTwist,
} from './store/features/createChar/noseSlice';
import {
  setDepth as setEyebrowsDepth,
  setHeight as setEyebrowsHeight,
} from './store/features/createChar/eyebrowSlice';
import {
  setDepth as setCheeksDepth,
  setHeight as setCheeksHeight,
  setWidth as setCheeksWidth,
} from './store/features/createChar/cheekSlice';
import {
  setOpening as setEyesOpening,
  setEyeColour,
} from './store/features/createChar/eyesSlice';
import { setThickness as setLipThickness } from './store/features/createChar/lipSlice';
import {
  setWidth as setJawWidth,
  setShape as setJawShape,
} from './store/features/createChar/jawSlice';
import {
  setDepth as setChinDepth,
  setLength as setChinLength,
  setShape as setChinShape,
  setHole as setChinHole,
} from './store/features/createChar/chinSlice';
import { setThickness as setNeckThickness } from './store/features/createChar/neckSlice';
import {
  setConfig,
  setDisabledMenusForPed,
  setLanguage,
} from './store/features/config/configSlice';
import { setTheme } from './store/features/config/themeSlice';
import {
  setchestTattooAmountOfTattoos,
  setchestTattooTattoosArray,
  setSelectedTattoos as setChestSelectedTattoos,
} from './store/features/tattoos/chestTattoosSlice';
import {
  setHeadTattooAmountOfTattoos,
  setHeadTattooTattoosArray,
  setSelectedTattoos as setHeadSelectedTattoos,
} from './store/features/tattoos/headTattoosSlice';
import {
  setleftarmTattooAmountOfTattoos,
  setleftarmTattooTattoosArray,
  setSelectedTattoos as seLeftarmSelectedTattoos,
} from './store/features/tattoos/leftarmTattoosSlice';
import {
  setleftlegTattooAmountOfTattoos,
  setleftlegTattooTattoosArray,
  setSelectedTattoos as setLeftlegSelectedTattoos,
} from './store/features/tattoos/leftlegTattoosSlice';
import {
  setrightarmTattooAmountOfTattoos,
  setrightarmTattooTattoosArray,
  setSelectedTattoos as setRightarmSelectedTattoos,
} from './store/features/tattoos/rightarmTattoosSlice';
import {
  setrightlegTattooAmountOfTattoos,
  setrightlegTattooTattoosArray,
  setSelectedTattoos as setRightlegSelectedTattoos,
} from './store/features/tattoos/rightlegTattoosSlice';
import './styles/_global.scss';
const Popup = lazy(() => import('./components/CardComponents/Popup/Popup'));
const CreateCharacterMenu = lazy(
  () => import('./components/CreateCharacterMenu/CreateCharacterMenu')
);
const ClothingMenu = lazy(
  () => import('./components/ClothingMenu/ClothingMenu')
);
const HairMenu = lazy(() => import('./components/HairMenu/HairMenu'));
const TattooMenu = lazy(() => import('./components/TattooMenu/TattooMenu'));
const OutfitMenu = lazy(() => import('./components/OutfitMenu/OutfitMenu'));
import Sidebar from './components/Sidebar/Sidebar';
import { fetchNui } from './utils/fetchNui';
import {
  setConfigOutfits,
  setCurrentOutfits,
} from './store/features/outfits/outfitSlice';
import { setCurrentClothingPage } from './store/features/pages/currentClothingPageSlice';
import { setCurrentCreateCharPage } from './store/features/pages/currentCreateCharPageSlice';
import { togglePopup } from './store/features/popup/popupSlice';

const updateRipples = () => {
  const buttonRipple: any =
    window.document.querySelectorAll('.ripple-animation');

  buttonRipple.forEach((button: any) => {
    button.onclick = ({
      pageY,
      currentTarget,
    }: {
      pageY: any;
      currentTarget: any;
    }) => {
      const x = 15;
      let y = pageY - currentTarget.offsetTop;
      if (y < 0) {
        y = 15;
      }
      const ripple = document.createElement('span');
      // make the style of the ripple with the overflow hidden
      ripple.classList.add('ripple-effect');
      ripple.style.left = `${x}px`;
      ripple.style.top = `${y}px`;
      button.appendChild(ripple);
      setTimeout(() => {
        ripple.remove();
      }, 600);
    };
  });
};

const App: React.FC = () => {
  const dispatch = useAppDistpatch();
  const [loaded, setLoaded] = useState(false);
  const [configLoaded, setConfigLoaded] = useState(false);
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const currentPage = useAppSelector(
    (state: any) => state.currentPage.currentPage
  );
  const theme = useAppSelector((state: any) => state.theme.theme);
  const disabledMenuForPeds = useAppSelector(
    (state: any) => state.config.disabledMenusForPed
  );
  const config = useAppSelector((state: any) => state.config.config);

  const updateBaseValue1 = (name: string, value: number) => {
    switch (name) {
      case 'arms':
        dispatch(setArmsBaseValue1(value));
        break;
      case 'bags':
        dispatch(setBagsBaseValue1(value));
        break;
      case 'bracelets':
        dispatch(setBraceletsBaseValue1(value));
        break;
      case 'chains':
        dispatch(setChainsBaseValue1(value));
        break;
      case 'decals':
        dispatch(setDecalsBaseValue1(value));
        break;
      case 'earrings':
        dispatch(setEarringsBaseValue1(value));
        break;
      case 'glasses':
        dispatch(setGlassesBaseValue1(value));
        break;
      case 'helmets':
        dispatch(setHelmetsBaseValue1(value));
        break;
      case 'jacket':
        dispatch(setJacketBaseValue1(value));
        break;
      case 'masks':
        dispatch(setMasksBaseValue1(value));
        break;
      case 'pants':
        dispatch(setPantsBaseValue1(value));
        break;
      case 'shoes':
        dispatch(setShoesBaseValue1(value));
        break;
      case 'undershirt':
        dispatch(setUndershirtBaseValue1(value));
        break;
      case 'vests':
        dispatch(setVestsBaseValue1(value));
        break;
      case 'watches':
        dispatch(setWatchesBaseValue1(value));
        break;
      case 'hair':
        dispatch(setHairBaseValue1(value));
        break;
      default:
        break;
    }
  };

  const updateBaseValue2 = (name: string, value: number) => {
    switch (name) {
      case 'arms':
        dispatch(setArmsBaseValue2(value));
        break;
      case 'bags':
        dispatch(setBagsBaseValue2(value));
        break;
      case 'bracelets':
        dispatch(setBraceletsBaseValue2(value));
        break;
      case 'chains':
        dispatch(setChainsBaseValue2(value));
        break;
      case 'decals':
        dispatch(setDecalsBaseValue2(value));
        break;
      case 'earrings':
        dispatch(setEarringsBaseValue2(value));
        break;
      case 'glasses':
        dispatch(setGlassesBaseValue2(value));
        break;
      case 'helmets':
        dispatch(setHelmetsBaseValue2(value));
        break;
      case 'jacket':
        dispatch(setJacketBaseValue2(value));
        break;
      case 'masks':
        dispatch(setMasksBaseValue2(value));
        break;
      case 'pants':
        dispatch(setPantsBaseValue2(value));
        break;
      case 'shoes':
        dispatch(setShoesBaseValue2(value));
        break;
      case 'undershirt':
        dispatch(setUndershirtBaseValue2(value));
        break;
      case 'vests':
        dispatch(setVestsBaseValue2(value));
        break;
      case 'watches':
        dispatch(setWatchesBaseValue2(value));
        break;
      case 'hair':
        dispatch(setHairBaseValue2(value));
        break;
      default:
        break;
    }
  };

  const updateMaxValue1 = (name: string, value: number) => {
    switch (name) {
      case 'arms':
        dispatch(setArmsMaxValue1(value));
        break;
      case 'bags':
        dispatch(setBagsMaxValue1(value));
        break;
      case 'bracelets':
        dispatch(setBraceletsMaxValue1(value));
        break;
      case 'chains':
        dispatch(setChainsMaxValue1(value));
        break;
      case 'decals':
        dispatch(setDecalsMaxValue1(value));
        break;
      case 'earrings':
        dispatch(setEarringsMaxValue1(value));
        break;
      case 'glasses':
        dispatch(setGlassesMaxValue1(value));
        break;
      case 'helmets':
        dispatch(setHelmetsMaxValue1(value));
        break;
      case 'jacket':
        dispatch(setJacketMaxValue1(value));
        break;
      case 'masks':
        dispatch(setMasksMaxValue1(value));
        break;
      case 'pants':
        dispatch(setPantsMaxValue1(value));
        break;
      case 'shoes':
        dispatch(setShoesMaxValue1(value));
        break;
      case 'undershirt':
        dispatch(setUndershirtMaxValue1(value));
        break;
      case 'vests':
        dispatch(setVestsMaxValue1(value));
        break;
      case 'watches':
        dispatch(setWatchesMaxValue1(value));
        break;
      case 'hair':
        dispatch(setHairMaxValue1(value));
        break;
      case 'age':
        dispatch(setAgeMaxValue1(value));
        break;
      case 'beard':
        dispatch(setBeardMaxValue1(value));
        break;
      case 'blemishes':
        dispatch(setBlemishesMaxValue1(value));
        break;
      case 'blush':
        dispatch(setBlushMaxValue1(value));
        break;
      case 'body':
        dispatch(setBodyMaxValue1(value));
        break;
      case 'chest':
        dispatch(setChestMaxValue1(value));
        break;
      case 'complexion':
        dispatch(setComplextionMaxValue1(value));
        break;
      case 'sundamage':
        dispatch(setSundamageMaxValue1(value));
        break;
      case 'eyebrows':
        dispatch(setEyebrowsMaxValue1(value));
        break;
      case 'lipstick':
        dispatch(setLipstickMaxValue1(value));
        break;
      case 'freckles':
        dispatch(setFrecklesMaxValue1(value));
        break;
      case 'makeup':
        dispatch(setMakeupMaxValue1(value));
        break;
      default:
        break;
    }
  };

  const updateMaxValue2 = (name: string, value: number) => {
    switch (name) {
      case 'arms':
        dispatch(setArmsMaxValue2(value));
        break;
      case 'bags':
        dispatch(setBagsMaxValue2(value));
        break;
      case 'bracelets':
        dispatch(setBraceletsMaxValue2(value));
        break;
      case 'chains':
        dispatch(setChainsMaxValue2(value));
        break;
      case 'decals':
        dispatch(setDecalsMaxValue2(value));
        break;
      case 'earrings':
        dispatch(setEarringsMaxValue2(value));
        break;
      case 'glasses':
        dispatch(setGlassesMaxValue2(value));
        break;
      case 'helmets':
        dispatch(setHelmetsMaxValue2(value));
        break;
      case 'jacket':
        dispatch(setJacketMaxValue2(value));
        break;
      case 'masks':
        dispatch(setMasksMaxValue2(value));
        break;
      case 'pants':
        dispatch(setPantsMaxValue2(value));
        break;
      case 'shoes':
        dispatch(setShoesMaxValue2(value));
        break;
      case 'undershirt':
        dispatch(setUndershirtMaxValue2(value));
        break;
      case 'vests':
        dispatch(setVestsMaxValue2(value));
        break;
      case 'watches':
        dispatch(setWatchesMaxValue2(value));
        break;
      case 'hair':
        dispatch(setHairMaxValue2(value));
        break;
      default:
        break;
    }
  };

  const updateColourID1 = (name: string, value: number) => {
    switch (name) {
      case 'hair':
        dispatch(setHairColourID1(value));
        break;
      case 'beard':
        dispatch(setBeardColourID1(value));
        break;
      case 'blush':
        dispatch(setBlushColourID1(value));
        break;
      case 'chest':
        dispatch(setChestColourID1(value));
        break;
      case 'eyebrows':
        dispatch(setEyebrowsColourID1(value));
        break;
      case 'lipstick':
        dispatch(setLipstickColourID1(value));
        break;
      case 'makeup':
        dispatch(setMakeupColourID1(value));
        break;
      default:
        break;
    }
  };

  const updateColourID2 = (name: string, value: number) => {
    switch (name) {
      case 'hair':
        dispatch(setHairColourID2(value));
        break;
    }
  };

  useEffect(() => {
    fetchNui('getConfig')
      .then((retData) => {
        dispatch(setConfig(retData));
        setConfigLoaded(true);
      })
      .catch((e) => {
        console.error('Setting mock data due to error', e);
      });
  }, []);

  useEffect(() => {
    fetchNui('getLanguage')
      .then((retData) => {
        dispatch(setLanguage(retData));
      })
      .catch((e) => {
        console.error('Setting mock data due to error', e);
      });
  }, []);

  useNuiEvent('setPage', (data) => {
    if (config.nui.whenPedDisableUneededMenus && disabledMenuForPeds) {
      dispatch(setCurrentPage(data));
      dispatch(setCurrentClothingPage('clothing'));
      dispatch(setCurrentCreateCharPage('faceFeatures'));
      if (data === 'createCharacter') {
        dispatch(setActiveDiv(1));
        return;
      }
      dispatch(setActiveDiv(0));
      return;
    }
    dispatch(setCurrentPage(data));
    dispatch(setCurrentClothingPage('clothing'));
    dispatch(setCurrentCreateCharPage('faceStructure'));
    dispatch(setActiveDiv(0));
    dispatch(togglePopup(false));
  });

  useNuiEvent('setMaxValues', (data) => {
    data.forEach((item: any) => {
      switch (item.type) {
        case 'variation':
          updateMaxValue1(item.name, item.maxValue1);
          updateMaxValue2(item.name, item.maxValue2);
          break;
        case 'prop':
          updateMaxValue1(item.name, item.maxValue1);
          updateMaxValue2(item.name, item.maxValue2);
          break;
        case 'overlay':
          updateMaxValue1(item.name, item.maxValue1);
          break;
        default:
          break;
      }
    });
  });

  useNuiEvent('updateTexture', (data) => {
    updateMaxValue2(data.name, data.value);
    updateBaseValue2(data.name, 0);
  });

  useNuiEvent('setCurrentPed', (data) => {
    dispatch(setPedOnFirstLoad(data));
    if (data === 'mp_f_freemode_01') {
      dispatch(setGender('female'));
      return;
    }
    dispatch(setGender('male'));
    return;
  });

  useNuiEvent('updateTattoos', (data) => {
    const torso = data['torso'];
    const head = data['head'];
    const leftArm = data['left_arm'];
    const rightArm = data['right_arm'];
    const leftLeg = data['left_leg'];
    const rightLeg = data['right_leg'];

    dispatch(setchestTattooAmountOfTattoos(torso.length));
    dispatch(setchestTattooTattoosArray(torso));
    dispatch(setHeadTattooTattoosArray(head));
    dispatch(setHeadTattooAmountOfTattoos(head.length));
    dispatch(setleftarmTattooTattoosArray(leftArm));
    dispatch(setleftarmTattooAmountOfTattoos(leftArm.length));
    dispatch(setrightarmTattooTattoosArray(rightArm));
    dispatch(setrightarmTattooAmountOfTattoos(rightArm.length));
    dispatch(setleftlegTattooTattoosArray(leftLeg));
    dispatch(setleftlegTattooAmountOfTattoos(leftLeg.length));
    dispatch(setrightlegTattooTattoosArray(rightLeg));
    dispatch(setrightlegTattooAmountOfTattoos(rightLeg.length));
  });

  useNuiEvent('updatePedStuff', (data) => {
    if (!data) {
      dispatch(setDisabledMenusForPed(true));
      return;
    }
    dispatch(setDisabledMenusForPed(false));
    return;
  });

  useNuiEvent('updateConfigOutfits', (data) => {
    dispatch(setConfigOutfits(data));
  });

  useNuiEvent('updatePlayerOutfits', (data) => {
    dispatch(setCurrentOutfits(data));
  });

  useNuiEvent('firstCharacter', (data) => {
    if (data) {
      dispatch(setDefaultValuesParent());
      dispatch(setDefaultValuesCheek());
      dispatch(setDefaultValuesChin());
      dispatch(setDefaultValuesEyebrow());
      dispatch(setDefaultValuesEyes());
      dispatch(setDefaultValuesJaw());
      dispatch(setDefaultValuesLip());
      dispatch(setDefaultValuesNeck());
      dispatch(setDefaultValuesNose());
    }
    updateBaseValue1('arms', 0);
    updateBaseValue1('bags', 0);
    updateBaseValue1('bracelets', -1);
    updateBaseValue1('chains', 0);
    updateBaseValue1('decals', 0);
    updateBaseValue1('earrings', -1);
    updateBaseValue1('glasses', -1);
    updateBaseValue1('helmets', -1);
    updateBaseValue1('jacket', 0);
    updateBaseValue1('masks', 0);
    updateBaseValue1('pants', 0);
    updateBaseValue1('shoes', 0);
    updateBaseValue1('undershirt', 0);
    updateBaseValue1('vests', 0);
    updateBaseValue1('watches', -1);
    updateBaseValue1('hair', 0);
  });

  useNuiEvent('updateFaceFeatures', (data) => {
    data.forEach((item: any) => {
      switch (item.name) {
        case 'noseWidth':
          dispatch(setNoseWidth(item.value));
          break;
        case 'nosePeak':
          dispatch(setNosePeak(item.value));
          break;
        case 'noseLength':
          dispatch(setNoseLength(item.value));
          break;
        case 'noseCurveness':
          dispatch(setNoseCurveness(item.value));
          break;
        case 'noseTip':
          dispatch(setNoseTip(item.value));
          break;
        case 'noseTwist':
          dispatch(setNoseTwist(item.value));
          break;
        case 'eyebrowsDepth':
          dispatch(setEyebrowsDepth(item.value));
          break;
        case 'eyebrowsHeight':
          dispatch(setEyebrowsHeight(item.value));
          break;
        case 'cheeksDepth':
          dispatch(setCheeksDepth(item.value));
          break;
        case 'cheeksHeight':
          dispatch(setCheeksHeight(item.value));
          break;
        case 'cheeksWidth':
          dispatch(setCheeksWidth(item.value));
          break;
        case 'eyesOpening':
          dispatch(setEyesOpening(item.value));
          break;
        case 'lipThickness':
          dispatch(setLipThickness(item.value));
          break;
        case 'jawWidth':
          dispatch(setJawWidth(item.value));
          break;
        case 'jawShape':
          dispatch(setJawShape(item.value));
          break;
        case 'chinDepth':
          dispatch(setChinDepth(item.value));
          break;
        case 'chinLength':
          dispatch(setChinLength(item.value));
          break;
        case 'chinShape':
          dispatch(setChinShape(item.value));
          break;
        case 'chinHole':
          dispatch(setChinHole(item.value));
          break;
        case 'neckThickness':
          dispatch(setNeckThickness(item.value));
          break;
        case 'eyesColour':
          dispatch(setEyeColour(item.value));
          break;
        case 'parents':
          dispatch(setMotherValue(0));
          dispatch(setFatherValue(0));
          dispatch(setMotherValue(item.motherValue));
          dispatch(setFatherValue(item.fatherValue));
          dispatch(setSimilarity(item.similarityValue));
          dispatch(setSkinColour(item.skinColour));
          break;
        default:
          break;
      }
    });
  });

  useNuiEvent('updateHairFeatures', (data) => {
    data.forEach((item: any) => {
      if (item.value === 255) {
        item.value = -1;
      }
      switch (item.name) {
        case 'hair':
          dispatch(setHairForFirstTime(item.value));
          break;
        case 'age':
          dispatch(setAgeForFirstTime(item.value));
          break;
        case 'beard':
          dispatch(setBeardForFirstTime(item.value));
          break;
        case 'blemishes':
          dispatch(setBlemishesForFirstTime(item.value));
          break;
        case 'blush':
          dispatch(setBlushForFirstTime(item.value));
          break;
        case 'body':
          dispatch(setBodyForFirstTime(item.value));
          break;
        case 'chest':
          dispatch(setChestForFirstTime(item.value));
          break;
        case 'complexion':
          dispatch(setComplextionForFirstTime(item.value));
          break;
        case 'sundamage':
          dispatch(setSundamageForFirstTime(item.value));
          break;
        case 'eyebrows':
          dispatch(setEyebrowsForFirstTime(item.value));
          break;
        case 'lipstick':
          dispatch(setLipstickForFirstTime(item.value));
          break;
        case 'freckles':
          dispatch(setFrecklesForFirstTime(item.value));
          break;
        case 'makeup':
          dispatch(setMakeupForFirstTime(item.value));
          break;
        default:
          break;
      }
      if (item.colour1) {
        updateColourID1(item.name, item.colour1);
      }
      if (item.colour2) {
        updateColourID2(item.name, item.colour2);
      }
      if (item.value2) {
        updateBaseValue2(item.name, 0);
        updateBaseValue2(item.name, item.value2);
      }
      if (!item.opacity) {
        return;
      }
      switch (item.name) {
        case 'age':
          dispatch(setAgeOpacity(item.opacity));
          break;
        case 'beard':
          dispatch(setBeardOpacity(item.opacity));
          break;
        case 'blemishes':
          dispatch(setBlemishesOpacity(item.opacity));
          break;
        case 'blush':
          dispatch(setBlushOpacity(item.opacity));
          break;
        case 'body':
          dispatch(setBodyOpacity(item.opacity));
          break;
        case 'chest':
          dispatch(setChestOpacity(item.opacity));
          break;
        case 'complexion':
          dispatch(setComplextionOpacity(item.opacity));
          break;
        case 'sundamage':
          dispatch(setSundamageOpacity(item.opacity));
          break;
        case 'eyebrows':
          dispatch(setEyebrowsOpacity(item.opacity));
          break;
        case 'lipstick':
          dispatch(setLipstickOpacity(item.opacity));
          break;
        case 'freckles':
          dispatch(setFrecklesOpacity(item.opacity));
          break;
        case 'makeup':
          dispatch(setMakeupOpacity(item.opacity));
          break;
        default:
          break;
      }
    });
  });

  useNuiEvent('updateClothingFeatures', (data) => {
    data.forEach((item: any) => {
      switch (item.name) {
        case 'arms':
          dispatch(setArmsForFirstTime(item.value1));
          break;
        case 'bags':
          dispatch(setBagsForFirstTime(item.value1));
          break;
        case 'bracelets':
          dispatch(setBraceletsForFirstTime(item.value1));
          break;
        case 'chains':
          dispatch(setChainsForFirstTime(item.value1));
          break;
        case 'decals':
          dispatch(setDecalsForFirstTime(item.value1));
          break;
        case 'earrings':
          dispatch(setEarringsForFirstTime(item.value1));
          break;
        case 'glasses':
          dispatch(setGlassesForFirstTime(item.value1));
          break;
        case 'helmets':
          dispatch(setHelmetsForFirstTime(item.value1));
          break;
        case 'jacket':
          dispatch(setJacketForFirstTime(item.value1));
          break;
        case 'masks':
          dispatch(setMasksForFirstTime(item.value1));
          break;
        case 'pants':
          dispatch(setPantsForFirstTime(item.value1));
          break;
        case 'shoes':
          dispatch(setShoesForFirstTime(item.value1));
          break;
        case 'undershirt':
          dispatch(setUndershirtForFirstTime(item.value1));
          break;
        case 'vests':
          dispatch(setVestsForFirstTime(item.value1));
          break;
        case 'watches':
          dispatch(setWatchesForFirstTime(item.value1));
          break;
        default:
          break;
      }
      updateBaseValue2(item.name, 0);
      updateBaseValue2(item.name, item.value2);
    });
  });

  useNuiEvent('updatePropFeatures', (data) => {
    data.forEach((item: any) => {
      switch (item.name) {
        case 'bracelets':
          dispatch(setBraceletsForFirstTime(item.value1));
          break;
        case 'earrings':
          dispatch(setEarringsForFirstTime(item.value1));
          break;
        case 'glasses':
          dispatch(setGlassesForFirstTime(item.value1));
          break;
        case 'helmets':
          dispatch(setHelmetsForFirstTime(item.value1));
          break;
        case 'watches':
          dispatch(setWatchesForFirstTime(item.value1));
          break;
        case 'bags':
          dispatch(setBagsForFirstTime(item.value1));
          break;
        case 'decals':
          dispatch(setDecalsForFirstTime(item.value1));
          break;
        case 'chains':
          dispatch(setChainsForFirstTime(item.value1));
          break;
        default:
          break;
      }
      updateBaseValue2(item.name, 0);
      updateBaseValue2(item.name, item.value2);
    });
  });

  useNuiEvent('setTattoos', (data) => {
    // console.log(JSON.stringify(data));
    const torso = data['torso'];
    const head = data['head'];
    const leftArm = data['leftarm'];
    const rightArm = data['rightarm'];
    const leftLeg = data['leftleg'];
    const rightLeg = data['rightleg'];
    dispatch(setChestSelectedTattoos(torso));
    dispatch(setHeadSelectedTattoos(head));
    dispatch(seLeftarmSelectedTattoos(leftArm));
    dispatch(setRightarmSelectedTattoos(rightArm));
    dispatch(setLeftlegSelectedTattoos(leftLeg));
    dispatch(setRightlegSelectedTattoos(rightLeg));
  });

  useNuiEvent('randomiseCharacter', (data) => {
    data.forEach((item: any) => {
      switch (item.name) {
        case 'hair':
          dispatch(setHairBaseValue1(0));
          dispatch(setHairBaseValue1(item.value));
          break;
        case 'nosewidth':
          dispatch(setNoseWidth(item.value));
          break;
        case 'nosepeak':
          dispatch(setNosePeak(item.value));
          break;
        case 'noselength':
          dispatch(setNoseLength(item.value));
          break;
        case 'nosecurveness':
          dispatch(setNoseCurveness(item.value));
          break;
        case 'nosetip':
          dispatch(setNoseTip(item.value));
          break;
        case 'nosetwist':
          dispatch(setNoseTwist(item.value));
          break;
        case 'eyebrowsdepth':
          dispatch(setEyebrowsDepth(item.value));
          break;
        case 'eyebrowsheight':
          dispatch(setEyebrowsHeight(item.value));
          break;
        case 'cheekdepth':
          dispatch(setCheeksDepth(item.value));
          break;
        case 'cheekheight':
          dispatch(setCheeksHeight(item.value));
          break;
        case 'cheekwidth':
          dispatch(setCheeksWidth(item.value));
          break;
        case 'eyesopening':
          dispatch(setEyesOpening(item.value));
          break;
        case 'lipthickness':
          dispatch(setLipThickness(item.value));
          break;
        case 'jawwidth':
          dispatch(setJawWidth(item.value));
          break;
        case 'jawshape':
          dispatch(setJawShape(item.value));
          break;
        case 'chindepth':
          dispatch(setChinDepth(item.value));
          break;
        case 'chinlength':
          dispatch(setChinLength(item.value));
          break;
        case 'chinshape':
          dispatch(setChinShape(item.value));
          break;
        case 'chinhole':
          dispatch(setChinHole(item.value));
          break;
        case 'neckthickness':
          dispatch(setNeckThickness(item.value));
          break;
        case 'eyescolour':
          dispatch(setEyeColour(item.value));
          break;
        case 'parents':
          dispatch(setMotherValue(0));
          dispatch(setFatherValue(0));
          dispatch(setMotherValue(item.mother));
          dispatch(setFatherValue(item.father));
          dispatch(setSimilarity(item.mix));
          dispatch(setSkinColour(item.skinColour));
          break;
        case 'colour':
          dispatch(setHairColourID1(item.value));
          dispatch(setBeardColourID1(item.value));
          dispatch(setChestColourID1(item.value));
          dispatch(setEyebrowsColourID1(item.value));
          break;
        case 'beard':
          dispatch(setBeardBaseValue1(0));
          dispatch(setBeardBaseValue1(item.value));
          break;
        case 'eyebrows':
          dispatch(setEyebrowsBaseValue1(0));
          dispatch(setEyebrowsBaseValue1(item.value));
          break;
        case 'makeup':
          dispatch(setMakeupBaseValue1(0));
          dispatch(setMakeupBaseValue1(item.value));
          break;
        case 'blemishes':
          dispatch(setBlemishesBaseValue1(0));
          dispatch(setBlemishesBaseValue1(item.value));
          break;
        case 'age':
          dispatch(setAgeBaseValue1(0));
          dispatch(setAgeBaseValue1(item.value));
          break;
        case 'blush':
          dispatch(setBlushBaseValue1(0));
          dispatch(setBlushBaseValue1(item.value));
          break;
        case 'chest':
          dispatch(setChestBaseValue1(0));
          dispatch(setChestBaseValue1(item.value));
          break;
        case 'lipstick':
          dispatch(setLipstickBaseValue1(0));
          dispatch(setLipstickBaseValue1(item.value));
          break;
        case 'freckles':
          dispatch(setFrecklesBaseValue1(0));
          dispatch(setFrecklesBaseValue1(item.value));
          break;
        case 'complextion':
          dispatch(setComplextionBaseValue1(0));
          dispatch(setComplextionBaseValue1(item.value));
          break;
        case 'sundamage':
          dispatch(setSundamageBaseValue1(0));
          dispatch(setSundamageBaseValue1(item.value));
          break;
        default:
          break;
      }
    });
  });

  useMemo(() => {
    const asyncConfig = async () => {
      const themeVariables = await getThemeVariables();
      dispatch(setTheme(themeVariables));
      setLoaded(true);
      updateRipples();
    };
    asyncConfig();
  }, []);

  const handleWheel = (e: any) => {
    if (e.x > 1300) {
      return;
    }
    if (e.x < 600) {
      return;
    }
    if (e.wheelDelta > 0) {
      sendNui('scrollwheelup', { x: e.x, y: e.y });
    } else {
      sendNui('scrollwheeldown');
    }
  };

  useEffect(() => {
    window.addEventListener('wheel', handleWheel);
    return () => {
      window.removeEventListener('wheel', handleWheel);
    };
  }, []);

  useEffect(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if (['Escape'].includes(e.code)) {
        // console.log('Escape pressed', currentPage);
        sendNui('hideFrame', { currentPage: currentPage });
      }
      if (e.code === 'KeyX') {
        sendNui('handsUp');
      }
    };

    window.addEventListener('keydown', keyHandler);
    return () => {
      window.removeEventListener('keydown', keyHandler);
    };
  }, [currentPage]);

  if (configLoaded && loaded) {
    return (
      <>
        <Draggable
          axis="x"
          onDrag={(e, data) => {
            const x: number = data.x;
            sendNui('dragging', { x: x });
            // reset the position when x gets big
          }}
          defaultPosition={{ x: 0, y: 0 }}
          position={position}
          onStop={(e, data) => {
            setPosition({ x: 0, y: 0 });
          }}
        >
          <div className="other-container"></div>
        </Draggable>
        <Suspense fallback={<h1>Loading...</h1>}>
          <Popup />
        </Suspense>
        <div
          className={`container ${
            config.nui['position'] === 'left'
              ? 'container-left'
              : 'container-right'
          }`}
          style={{
            backgroundColor: theme.background['container'],
            boxShadow: theme.background['box-shadow'],
          }}
        >
          {currentPage === 'clothing' && (
            <Suspense fallback={<h1>Loading...</h1>}>
              <ClothingMenu />
            </Suspense>
          )}
          {currentPage === 'hair' && (
            <Suspense fallback={<h1>Loading...</h1>}>
              <HairMenu />
            </Suspense>
          )}
          {currentPage === 'tattoo' && (
            <Suspense fallback={<h1>Loading...</h1>}>
              <TattooMenu />
            </Suspense>
          )}
          {currentPage === 'createCharacter' && (
            <Suspense fallback={<h1>Loading...</h1>}>
              <CreateCharacterMenu />
            </Suspense>
          )}
          {currentPage === 'outfits' && (
            <Suspense fallback={<h1>Loading...</h1>}>
              <OutfitMenu />
            </Suspense>
          )}
          <Sidebar />
        </div>
      </>
    );
  } else {
    return <>Loading</>;
  }
};

export default App;
