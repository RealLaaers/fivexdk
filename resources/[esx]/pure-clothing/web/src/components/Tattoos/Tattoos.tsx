import React from 'react';
import tattoosMenuItems from '../../menus/tattoosMenuItems';
import { useAppDistpatch } from '../../store/store';
import { setSelectedTattoos } from '../../store/features/tattoos/headTattoosSlice';
import { setSelectedTattoos as setChestTattoos } from '../../store/features/tattoos/chestTattoosSlice';
import { setSelectedTattoos as setLeftArmTattoos } from '../../store/features/tattoos/leftarmTattoosSlice';
import { setSelectedTattoos as setRightArmTattoos } from '../../store/features/tattoos/rightarmTattoosSlice';
import { setSelectedTattoos as setLeftLegTattoos } from '../../store/features/tattoos/leftlegTattoosSlice';
import { setSelectedTattoos as setRightLegTattoos } from '../../store/features/tattoos/rightlegTattoosSlice';
import Tattoo from './AllComponents/Tattoo';

const Tattoos: React.FC = () => {
  const dispatch = useAppDistpatch();

  return (
    <>
      {tattoosMenuItems.map((item: any) => {
        const nameOfFunc = item.nameOfState;

        let setTattooArray = (array: any) => {
          console.log(array, 'array');
        };

        if (nameOfFunc === 'headTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setSelectedTattoos(array));
          };
        } else if (nameOfFunc === 'chestTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setChestTattoos(array));
          };
        } else if (nameOfFunc === 'leftarmTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setLeftArmTattoos(array));
          };
        } else if (nameOfFunc === 'rightarmTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setRightArmTattoos(array));
          };
        } else if (nameOfFunc === 'leftlegTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setLeftLegTattoos(array));
          };
        } else if (nameOfFunc === 'rightlegTattoos') {
          setTattooArray = (array: any) => {
            dispatch(setRightLegTattoos(array));
          };
        }

        const handleClick = (array: any) => {
          // console.log(array, 'array');
          setTattooArray(array);
        };

        return (
          <Tattoo
            key={item.id}
            headingName={item.name}
            nameOfState={item.nameOfState}
            handleClickFunc={handleClick}
            id={item.id}
          />
        );
      })}
    </>
  );
};

export default Tattoos;
