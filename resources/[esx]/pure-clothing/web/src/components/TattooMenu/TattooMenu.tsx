import React from 'react';
import '../Component.scss';
import Tattoos from '../Tattoos/Tattoos';
import { useAppSelector } from '../../store/store';

const TattooMenu: React.FC = () => {
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
        <Tattoos />
      </section>
    </>
  );
};

export default TattooMenu;
