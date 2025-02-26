import React, { useEffect, Suspense, lazy } from 'react';
import { useAppDistpatch, useAppSelector } from '../../../store/store';
import './Popup.scss';
import { togglePopup } from '../../../store/features/popup/popupSlice';
import updateRipples from '../../../utils/updateRipple';
// import InfoPopup from './InfoPopup/InfoPopup';
// import SavePopup from './SavePopup/SavePopup';
// import DeletePopup from './DeletePopup/DeletePopup';
const InfoPopup = lazy(() => import('./InfoPopup/InfoPopup'));
const SavePopup = lazy(() => import('./SavePopup/SavePopup'));
const DeletePopup = lazy(() => import('./DeletePopup/DeletePopup'));
const TattooPopup = lazy(() => import('./TattooPopup/TattooPopup'));
const RandomiserPopup = lazy(() => import('./RandomiserPopup/RandomiserPopup'));

const Popup: React.FC = () => {
  const showPopup = useAppSelector((state) => state.togglePopup.showPopup);
  const config = useAppSelector((state) => state.config.config);
  const currentPopupPage = useAppSelector(
    (state) => state.togglePopup.popupPage
  );

  useEffect(() => {
    updateRipples();
  }, [showPopup]);

  return (
    <>
      {showPopup ? (
        <>
          {' '}
          {currentPopupPage === 'info' && (
            <Suspense fallback={<div>Loading...</div>}>
              <InfoPopup />
            </Suspense>
          )}
          {currentPopupPage === 'save' && config.saveDeletePopup && (
            <Suspense fallback={<div>Loading...</div>}>
              <SavePopup />
            </Suspense>
          )}
          {currentPopupPage === 'delete' && config.saveDeletePopup && (
            <Suspense fallback={<div>Loading...</div>}>
              <DeletePopup />
            </Suspense>
          )}
          {currentPopupPage === 'tattooClear' && (
            <Suspense fallback={<div>Loading...</div>}>
              <TattooPopup />
            </Suspense>
          )}
          {currentPopupPage === 'randomiser' && (
            <Suspense fallback={<div>Loading...</div>}>
              <RandomiserPopup />
            </Suspense>
          )}
        </>
      ) : null}
    </>
  );
};

export default Popup;
