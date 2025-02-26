import React from 'react';
import { useAppDistpatch, useAppSelector } from '../../../store/store';
import { togglePopup } from '../../../store/features/popup/popupSlice';
import '../../CardComponents/Popup/Popup.scss';
import { sendNui } from '../../../utils/sendNui';

interface Props {
  closeFunc: (showPopup: boolean) => void;
  currentOutfit: any;
}

const DeleteOutfitPopup: React.FC<Props> = (props) => {
  const theme = useAppSelector((state) => state.theme.theme);
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
          <h1>{language.popouts.deleteOutfitPopup.title}</h1>
        </div>
        <div className="middle" style={{ color: theme.text['grey-faded'] }}>
          <h3>{language.popouts.deleteOutfitPopup.message}</h3>
        </div>
        <div>
          <div className="bottom">
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                // dispatch(togglePopup(!showPopup));
                props.closeFunc(false);
              }}
              style={{
                backgroundColor: theme.sidebar['delete'],
                color: theme.text['white'],
              }}
            >
              {language.general.cancel}
            </div>
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                // dispatch(togglePopup(!showPopup));
                // sendNui('clearTattoos');
                props.closeFunc(false);
                sendNui('deleteCurrentOutfit', props.currentOutfit);
              }}
              style={{
                backgroundColor: theme.sidebar['save'],
                color: theme.text['white'],
              }}
            >
              {language.general.delete}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default DeleteOutfitPopup;
