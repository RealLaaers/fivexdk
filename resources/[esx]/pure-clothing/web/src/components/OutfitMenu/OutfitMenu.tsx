import React from 'react';
import '../Component.scss';
import Outfits from '../Outfits/Outfits';
import { useAppSelector } from '../../store/store';

const OutfitMenu: React.FC = () => {
  const config = useAppSelector((state: any) => state.config.config);

  return (
    <>
      <section
        className={`mainHousing ${
          config.nui['position'] === 'left'
            ? 'mainHousing-left'
            : 'mainHousing-right'
        }`}
      >
        <Outfits />
      </section>
    </>
  );
};

export default OutfitMenu;
