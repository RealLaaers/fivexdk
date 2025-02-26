import React from 'react';
import { useAppSelector, useAppDistpatch } from '../../store/store';
import hairMenuItems from '../../menus/hairMenuItems';
import {
  setAgeBaseValue1,
  setAgeBaseValue1ByInput,
  setAgeColourID1,
  setAgeColourID2,
  setAgeOpacity,
} from '../../store/features/hair/ageSlice';
import {
  setBeardBaseValue1,
  setBeardBaseValue1ByInput,
  setBeardColourID1,
  setBeardColourID2,
  setBeardOpacity,
} from '../../store/features/hair/beardSlice';
import {
  setBlemishesBaseValue1,
  setBlemishesBaseValue1ByInput,
  setBlemishesColourID1,
  setBlemishesColourID2,
  setBlemishesOpacity,
} from '../../store/features/hair/blemishesSlice';
import {
  setBlushBaseValue1,
  setBlushBaseValue1ByInput,
  setBlushColourID1,
  setBlushColourID2,
  setBlushOpacity,
} from '../../store/features/hair/blushSlice';
import {
  setBodyBaseValue1,
  setBodyBaseValue1ByInput,
  setBodyColourID1,
  setBodyColourID2,
  setBodyOpacity,
} from '../../store/features/hair/bodySlice';
import {
  setChestBaseValue1,
  setChestBaseValue1ByInput,
  setChestColourID1,
  setChestColourID2,
  setChestOpacity,
} from '../../store/features/hair/chestSlice';
import {
  setEyebrowsBaseValue1,
  setEyebrowsBaseValue1ByInput,
  setEyebrowsColourID1,
  setEyebrowsColourID2,
  setEyebrowsOpacity,
} from '../../store/features/hair/eyebrowsSlice';
import {
  setHairBaseValue1,
  setHairBaseValue1ByInput,
  setHairColourID1,
  setHairColourID2,
  setHairOpacity,
} from '../../store/features/hair/hairSlice';
import {
  setLipstickBaseValue1,
  setLipstickBaseValue1ByInput,
  setLipstickColourID1,
  setLipstickColourID2,
  setLipstickOpacity,
} from '../../store/features/hair/lipstickSlice';
import {
  setFrecklesBaseValue1,
  setFrecklesBaseValue1ByInput,
  setFrecklesColourID1,
  setFrecklesColourID2,
  setFrecklesOpacity,
} from '../../store/features/hair/frecklesSlice';
import {
  setMakeupBaseValue1,
  setMakeupBaseValue1ByInput,
  setMakeupColourID1,
  setMakeupColourID2,
  setMakeupOpacity,
} from '../../store/features/hair/makeupSlice';
import {
  setComplextionBaseValue1,
  setComplextionBaseValue1ByInput,
  setComplextionColourID1,
  setComplextionColourID2,
  setComplextionOpacity,
} from '../../store/features/hair/complextionSlice';
import {
  setSundamageBaseValue1,
  setSundamageBaseValue1ByInput,
  setSundamageColourID1,
  setSundamageColourID2,
  setSundamageOpacity,
} from '../../store/features/hair/sundamageSlice';
import HairComp from './AllComponents/HairComp';

const Hair: React.FC = () => {
  return (
    <>
      {' '}
      {hairMenuItems.map((item) => {
        const dispatch = useAppDistpatch();
        const nameOfFunc = item.nameOfState;
        const disabledMenuForPeds = useAppSelector(
          (state: any) => state.config.disabledMenusForPed
        );
        const config = useAppSelector((state: any) => state.config.config);
        if (
          disabledMenuForPeds &&
          config.nui.whenPedDisableUneededMenus &&
          nameOfFunc !== 'hair'
        ) {
          return null;
        }
        // console.log(nameOfFunc, 'nameOfFunc');

        let setBaseValue1 = (math: number) => {
          console.log('setBaseValue1');
        };

        let setBaseValue1ByInput = (math: number) => {
          console.log('setBaseValue1ByInput');
        };

        let setOpacity = (math: number) => {
          console.log('setOpacity');
        };

        let setColourID1 = (math: number) => {
          console.log('setColourID1');
        };

        let setColourID2 = (math: number) => {
          console.log('setColourID2');
        };

        if (nameOfFunc === 'age') {
          setBaseValue1 = (math: number) => {
            dispatch(setAgeBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setAgeBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setAgeOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setAgeColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setAgeColourID2(math));
          };
        } else if (nameOfFunc === 'beard') {
          setBaseValue1 = (math: number) => {
            dispatch(setBeardBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBeardBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setBeardOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setBeardColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setBeardColourID2(math));
          };
        } else if (nameOfFunc === 'blemishes') {
          setBaseValue1 = (math: number) => {
            dispatch(setBlemishesBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBlemishesBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setBlemishesOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setBlemishesColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setBlemishesColourID2(math));
          };
        } else if (nameOfFunc === 'blush') {
          setBaseValue1 = (math: number) => {
            dispatch(setBlushBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBlushBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setBlushOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setBlushColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setBlushColourID2(math));
          };
        } else if (nameOfFunc === 'body') {
          setBaseValue1 = (math: number) => {
            dispatch(setBodyBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setBodyBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setBodyOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setBodyColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setBodyColourID2(math));
          };
        } else if (nameOfFunc === 'chest') {
          setBaseValue1 = (math: number) => {
            dispatch(setChestBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setChestBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setChestOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setChestColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setChestColourID2(math));
          };
        } else if (nameOfFunc === 'eyebrows') {
          setBaseValue1 = (math: number) => {
            dispatch(setEyebrowsBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setEyebrowsBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setEyebrowsOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setEyebrowsColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setEyebrowsColourID2(math));
          };
        } else if (nameOfFunc === 'hair') {
          setBaseValue1 = (math: number) => {
            dispatch(setHairBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setHairBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setHairOpacity(math));
          };

          setColourID1 = (math: number) => {
            dispatch(setHairColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setHairColourID2(math));
          };
        } else if (nameOfFunc === 'lipstick') {
          setBaseValue1 = (math: number) => {
            dispatch(setLipstickBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setLipstickBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setLipstickOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setLipstickColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setLipstickColourID2(math));
          };
        } else if (nameOfFunc === 'freckles') {
          setBaseValue1 = (math: number) => {
            dispatch(setFrecklesBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setFrecklesBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setFrecklesOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setFrecklesColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setFrecklesColourID2(math));
          };
        } else if (nameOfFunc === 'makeup') {
          setBaseValue1 = (math: number) => {
            dispatch(setMakeupBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setMakeupBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setMakeupOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setMakeupColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setMakeupColourID2(math));
          };
        } else if (nameOfFunc === 'complextion') {
          setBaseValue1 = (math: number) => {
            dispatch(setComplextionBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setComplextionBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setComplextionOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setComplextionColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setComplextionColourID2(math));
          };
        } else if (nameOfFunc === 'sundamage') {
          setBaseValue1 = (math: number) => {
            dispatch(setSundamageBaseValue1(math));
          };
          setBaseValue1ByInput = (math: number) => {
            dispatch(setSundamageBaseValue1ByInput(math));
          };
          setOpacity = (math: number) => {
            dispatch(setSundamageOpacity(math));
          };
          setColourID1 = (math: number) => {
            dispatch(setSundamageColourID1(math));
          };
          setColourID2 = (math: number) => {
            dispatch(setSundamageColourID2(math));
          };
        }

        const handleClick = (id: string, math: number, context: string) => {
          // console.log(id, math, context);
          if (id.includes('_1_input')) {
            setBaseValue1ByInput(math);
            return;
          } else if (context === 'id_1') {
            setBaseValue1(math);
            return;
          }
          if (context === 'opacity') {
            setOpacity(math);
            return;
          }
          if (context === 'colour') {
            if (id.includes('colour2')) {
              setColourID2(math);
              return;
            }
            setColourID1(math);
            return;
          }
        };
        return (
          <HairComp
            key={item.id}
            headingName={item.name}
            handleClickFunc={handleClick}
            nameOfState={item.nameOfState}
            icon={item.icon}
            id_1={item.id_1}
            opacity={item.opacity}
            colourID_1={item.colourID1}
            colourID_2={item.colourID2}
            enableSlider={item.enableSlider}
            enableColourBoxes={item.enableColourBoxes}
          />
        );
      })}
    </>
  );
};

export default Hair;
