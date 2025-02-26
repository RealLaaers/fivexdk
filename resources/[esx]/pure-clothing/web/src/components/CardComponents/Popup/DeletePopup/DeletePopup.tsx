import React from 'react';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import { togglePopup } from '../../../../store/features/popup/popupSlice';
import '../Popup.scss';
import { sendNui } from '../../../../utils/sendNui';

const DeletePopup: React.FC = () => {
  const showPopup = useAppSelector((state) => state.togglePopup.showPopup);
  const theme = useAppSelector((state) => state.theme.theme);
  const dispatch = useAppDistpatch();
  const currentPage = useAppSelector((state) => state.currentPage.currentPage);
  const language = useAppSelector((state) => state.config.language);

  return (
    <div
      className="popupContainer discardHeight"
      style={{
        backgroundColor: theme.background['clothing-main'],
        borderRadius: theme.borders['border-radius'],
        color: theme.text['white'],
        boxShadow: theme.background['box-shadow'],
      }}
    >
      <div className="spitIntoGrids saveHeight">
        <div>
          <h1>{language.popouts.deletePopup.title}</h1>
        </div>
        <div className="middle" style={{ color: theme.text['grey-faded'] }}>
          <h3>{language.popouts.deletePopup.message}</h3>
        </div>
        <div>
          <div className="bottom">
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                dispatch(togglePopup(!showPopup));
                sendNui('deleteButton', {
                  currentPage: currentPage,
                });
              }}
              style={{
                backgroundColor: theme.sidebar['delete'],
                color: theme.text['white'],
              }}
            >
              {language.general.discard}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default DeletePopup;
