import React from 'react';
import { useAppSelector } from '../../../store/store';
import { sendNui } from '../../../utils/sendNui';
import '../SharePopup/SharePopup.scss';

interface Props {
  closeFunc: (close: boolean) => void;
  currentOutfit: any;
}

const AcceptPopup: React.FC<Props> = (props) => {
  const theme = useAppSelector((state) => state.theme.theme);
  const langauge = useAppSelector((state) => state.config.language);

  return (
    <div
      className="popupContainer customHeight"
      style={{
        backgroundColor: theme.background['clothing-main'],
        borderRadius: theme.borders['border-radius'],
        color: theme.text['white'],
        boxShadow: theme.background['box-shadow'],
      }}
    >
      <div className="spitIntoGrids saveHeight">
        <div className="top">
          <h1>{langauge.popouts.acceptOutfitPopup.title}</h1>
        </div>
        <div className="middle" style={{ color: theme.text['grey-faded'] }}>
          <h3>{langauge.popouts.acceptOutfitPopup.message}</h3>
          <h3>
            {langauge.popouts.acceptOutfitPopup.message2}{' '}
            {props.currentOutfit.name}
          </h3>
        </div>
        <div className="bottom">
          <div
            className="ripple-animation button cancel"
            onClick={() => {
              props.closeFunc(false);
              sendNui('acceptOutfit', props.currentOutfit);
            }}
            style={{
              backgroundColor: theme.sidebar['save'],
              color: theme.text['white'],
            }}
          >
            {langauge.general.save}
          </div>
          <div
            className="ripple-animation button cancel"
            onClick={() => {
              props.closeFunc(false);
            }}
            style={{
              backgroundColor: theme.sidebar['delete'],
              color: theme.text['white'],
            }}
          >
            {langauge.general.close}
          </div>
        </div>
      </div>
    </div>
  );
};

export default AcceptPopup;
