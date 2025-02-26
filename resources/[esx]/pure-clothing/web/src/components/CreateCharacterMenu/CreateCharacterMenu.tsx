import React, { Suspense, lazy } from 'react';
import { useAppSelector } from '../../store/store';
const Outfits = lazy(() => import('../Outfits/Outfits'));
const FaceStructureComponents = lazy(
  () => import('./FaceStructureComponents/FaceStructureComponents')
);
const Peds = lazy(() => import('./PedsComponents/Peds'));
const Tattoos = lazy(() => import('../Tattoos/Tattoos'));
const Hair = lazy(() => import('../Hair/Hair'));
const Clothing = lazy(() => import('../Clothing/Clothing'));
const Props = lazy(() => import('../Clothing/Props/Props'));
import '../Component.scss';

const CreateCharacterMenu: React.FC = () => {
  const currentCharacterCharPage = useAppSelector(
    (state) => state.currentCreateCharPage.currentPage
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
        {currentCharacterCharPage === 'faceStructure' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <FaceStructureComponents />
          </Suspense>
        )}
        {currentCharacterCharPage === 'faceFeatures' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Hair />
          </Suspense>
        )}
        {currentCharacterCharPage === 'peds' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Peds />
          </Suspense>
        )}
        {currentCharacterCharPage === 'clothing' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Clothing />
          </Suspense>
        )}
        {currentCharacterCharPage === 'props' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Props />
          </Suspense>
        )}
        {currentCharacterCharPage === 'tattoos' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Tattoos />
          </Suspense>
        )}
        {currentCharacterCharPage === 'outfits' && (
          <Suspense fallback={<h1>Loading...</h1>}>
            <Outfits />
          </Suspense>
        )}
      </section>
    </>
  );
};

export default CreateCharacterMenu;
