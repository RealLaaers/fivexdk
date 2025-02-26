import React from 'react';
import propsMenuItems from '../../../menus/propsMenuItems';
import { useAppDistpatch } from '../../../store/store';
import {
  setWatchesBaseValue1,
  setWatchesBaseValue2,
  setWatchesValue1ByInput,
  setWatchesValue2ByInput,
} from '../../../store/features/clothing/watchesSlice';
import {
  setBagsBaseValue1,
  setBagsBaseValue2,
  setBagsBaseValue1ByInput,
  setBagsBaseValue2ByInput,
} from '../../../store/features/clothing/bagsSlice';
import {
  setBraceletsBaseValue1,
  setBraceletsBaseValue2,
  setBraceletsBaseValue1ByInput,
  setBraceletsBaseValue2ByInput,
} from '../../../store/features/clothing/braceletsSlice';
import {
  setChainsBaseValue1,
  setChainsBaseValue2,
  setChainsBaseValue1ByInput,
  setChainsBaseValue2ByInput,
} from '../../../store/features/clothing/chainsSlice';
import {
  setDecalsBaseValue1,
  setDecalsBaseValue2,
  setDecalsBaseValue1ByInput,
  setDecalsBaseValue2ByInput,
} from '../../../store/features/clothing/decalsSlice';
import {
  setGlassesBaseValue1,
  setGlassesBaseValue2,
  setGlassesBaseValue1ByInput,
  setGlassesBaseValue2ByInput,
} from '../../../store/features/clothing/glassesSlice';
import {
  setHelmetsBaseValue1,
  setHelmetsBaseValue2,
  setHelmetsBaseValue1ByInput,
  setHelmetsBaseValue2ByInput,
} from '../../../store/features/clothing/helmetsSlice';
import {
  setEarringsBaseValue1,
  setEarringsBaseValue2,
  setEarringsBaseValue1ByInput,
  setEarringsBaseValue2ByInput,
} from '../../../store/features/clothing/earringsSlice';
import ClothingComp from '../AllComponents/ClothingComp';

const Props: React.FC = () => {
  return (
    <>
      {' '}
      {propsMenuItems.map((item) => {
        const dispatch = useAppDistpatch();
        const nameOfFunc = item.nameOfState;

        let setBaseValue1: (math: number) => void;
        let setBaseValue2: (math: number) => void;
        let setBaseValue1ByInput: (math: number) => void;
        let setBaseValue2ByInput: (math: number) => void;

        if (nameOfFunc === 'bags') {
          setBaseValue1 = (math: number) => {
            dispatch(setBagsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setBagsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBagsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setBagsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'bracelets') {
          setBaseValue1 = (math: number) => {
            dispatch(setBraceletsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setBraceletsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBraceletsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setBraceletsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'chains') {
          setBaseValue1 = (math: number) => {
            dispatch(setChainsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setChainsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setChainsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setChainsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'decals') {
          setBaseValue1 = (math: number) => {
            dispatch(setDecalsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setDecalsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setDecalsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setDecalsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'glasses') {
          setBaseValue1 = (math: number) => {
            dispatch(setGlassesBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setGlassesBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setGlassesBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setGlassesBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'helmets') {
          setBaseValue1 = (math: number) => {
            dispatch(setHelmetsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setHelmetsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setHelmetsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setHelmetsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'watches') {
          setBaseValue1 = (math: number) => {
            dispatch(setWatchesBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setWatchesBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setWatchesValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setWatchesValue2ByInput(math));
          };
        } else if (nameOfFunc === 'earrings') {
          setBaseValue1 = (math: number) => {
            dispatch(setEarringsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setEarringsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setEarringsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setEarringsBaseValue2ByInput(math));
          };
        }

        const handleClick = (id: string, math: number) => {
          // console.log(id, math);
          if (id.includes('_1_input')) {
            setBaseValue1ByInput(math);
            return;
          } else if (id.includes('_2_input')) {
            setBaseValue2ByInput(math);
            return;
          } else if (id.includes('_1')) {
            setBaseValue1(math);
            return;
          }
          setBaseValue2(math);
        };

        return (
          <ClothingComp
            key={item.id}
            nameOfState={item.nameOfState}
            headingName={item.name}
            handleClickFunc={handleClick}
            icon={item.icon}
            id_1={item.one}
            id_2={item.two}
            isProps={true}
          />
        );
      })}
    </>
  );
};

export default Props;
