import React from 'react';
import '../Component.scss';
import Hair from '../Hair/Hair';
import { useAppSelector } from '../../store/store';

const HairMenu: React.FC = () => {
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
        <Hair />
      </section>
    </>
  );
};

export default HairMenu;
