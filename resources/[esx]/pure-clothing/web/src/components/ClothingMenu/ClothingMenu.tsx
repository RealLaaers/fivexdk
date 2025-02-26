import React, { Suspense, lazy } from 'react';
import { useAppSelector } from '../../store/store';
import '../Component.scss';
const Clothing = lazy(() => import('../Clothing/Clothing'));
const Props = lazy(() => import('../Clothing/Props/Props'));
const Outfits = lazy(() => import('../Outfits/Outfits'));

const ClothingMenu: React.FC = () => {
  const currentClothingPage = useAppSelector(
    (state) => state.currentClothingPage.currentPage
  );

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
        {currentClothingPage === 'clothing' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Clothing />
          </Suspense>
        )}
        {currentClothingPage === 'props' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Props />
          </Suspense>
        )}
        {currentClothingPage === 'outfits' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Outfits />
          </Suspense>
        )}
      </section>
    </>
  );
};

export default ClothingMenu;
