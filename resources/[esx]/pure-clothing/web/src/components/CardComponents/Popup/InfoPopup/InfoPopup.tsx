import React from 'react';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import { togglePopup } from '../../../../store/features/popup/popupSlice';
import '../Popup.scss';

const InfoPopup: React.FC = () => {
  const showPopup = useAppSelector((state) => state.togglePopup.showPopup);
  const theme = useAppSelector((state) => state.theme.theme);
  const dispatch = useAppDistpatch();
  const language = useAppSelector((state) => state.config.language);

  return (
    <div
      className="popupContainer infoHeight"
      style={{
        backgroundColor: theme.background['clothing-main'],
        borderRadius: theme.borders['border-radius'],
        color: theme.text['white'],
        boxShadow: theme.background['box-shadow'],
      }}
    >
      <div className="spitIntoGrids saveHeight">
        <div>
          <h1>{language.popouts.infoPopup.title}</h1>
        </div>
        <div className="middle" style={{ color: theme.text['grey-faded'] }}>
          <h3>{language.popouts.infoPopup.message1}</h3>
          <h3>{language.popouts.infoPopup.message2}</h3>
          <h3>{language.popouts.infoPopup.message3}</h3>
          <h3>{language.popouts.infoPopup.message4}</h3>
        </div>
        <div>
          <div className="bottom">
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                dispatch(togglePopup(!showPopup));
              }}
              style={{
                backgroundColor: theme.sidebar['info'],
                color: theme.text['white'],
              }}
            >
              {language.general.close}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default InfoPopup;
