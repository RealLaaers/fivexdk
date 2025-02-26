import React from 'react';
import { useAppDistpatch } from '../../store/store';
import {
  setJacketBaseValue1,
  setJacketBaseValue2,
  setJacketBaseValue1ByInput,
  setJacketBaseValue2ByInput,
} from '../../store/features/clothing/jacketSlice';
import {
  setUndershirtBaseValue1,
  setUndershirtBaseValue2,
  setUndershirtBaseValue1ByInput,
  setUndershirtBaseValue2ByInput,
} from '../../store/features/clothing/undershirtSlice';
import {
  setArmsBaseValue1,
  setArmsBaseValue2,
  setArmsBaseValue1ByInput,
  setArmsBaseValue2ByInput,
} from '../../store/features/clothing/armsSlice';
import {
  setMasksBaseValue1,
  setMasksBaseValue2,
  setMasksBaseValue1ByInput,
  setMasksBaseValue2ByInput,
} from '../../store/features/clothing/masksSlice';
import {
  setPantsBaseValue1,
  setPantsBaseValue2,
  setPantsBaseValue1ByInput,
  setPantsBaseValue2ByInput,
} from '../../store/features/clothing/pantsSlice';
import {
  setShoesBaseValue1,
  setShoesBaseValue2,
  setShoesBaseValue1ByInput,
  setShoesBaseValue2ByInput,
} from '../../store/features/clothing/shoesSlice';
import {
  setVestsBaseValue1,
  setVestsBaseValue2,
  setVestsBaseValue1ByInput,
  setVestsBaseValue2ByInput,
} from '../../store/features/clothing/vestsSlice';
import clothingMenuItems from '../../menus/clothingMenuItems';
import ClothingComp from './AllComponents/ClothingComp';

const Clothing: React.FC = () => {
  return (
    <>
      {clothingMenuItems.map((item) => {
        const dispatch = useAppDistpatch();
        const nameOfFunc = item.nameOfState;

        let setBaseValue1 = (math: number) => {
          console.log('setBaseValue1');
        };
        let setBaseValue2 = (math: number) => {
          console.log('setBaseValue2');
        };
        let setBaseValue1ByInput = (math: number) => {
          console.log('setBaseValue1ByInput');
        };
        let setBaseValue2ByInput = (math: number) => {
          console.log('setBaseValue2ByInput');
        };

        if (nameOfFunc === 'jacket') {
          setBaseValue1 = (math: number) => {
            dispatch(setJacketBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setJacketBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setJacketBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setJacketBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'vests') {
          setBaseValue1 = (math: number) => {
            dispatch(setVestsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setVestsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setVestsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setVestsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'undershirt') {
          setBaseValue1 = (math: number) => {
            dispatch(setUndershirtBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setUndershirtBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setUndershirtBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setUndershirtBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'arms') {
          setBaseValue1 = (math: number) => {
            dispatch(setArmsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setArmsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setArmsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setArmsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'masks') {
          setBaseValue1 = (math: number) => {
            dispatch(setMasksBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setMasksBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setMasksBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setMasksBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'pants') {
          setBaseValue1 = (math: number) => {
            dispatch(setPantsBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setPantsBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setPantsBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setPantsBaseValue2ByInput(math));
          };
        } else if (nameOfFunc === 'shoes') {
          setBaseValue1 = (math: number) => {
            dispatch(setShoesBaseValue1(math));
          };
          setBaseValue2 = (math: number) => {
            dispatch(setShoesBaseValue2(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setShoesBaseValue1ByInput(math));
          };
          setBaseValue2ByInput = (math: number) => {
            dispatch(setShoesBaseValue2ByInput(math));
          };
        }

        const handleClick = (id: string, math: number) => {
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
            isProps={false}
          />
        );
      })}
    </>
  );
};

export default Clothing;
