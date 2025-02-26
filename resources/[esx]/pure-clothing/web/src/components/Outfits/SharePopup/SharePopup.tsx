import React, { useEffect, useState } from 'react';
import { useAppSelector } from '../../../store/store';
import { sendNui } from '../../../utils/sendNui';
import { fetchNui } from '../../../utils/fetchNui';
import './SharePopup.scss';

interface Props {
  closeFunc: (close: boolean) => void;
  currentOutfit: any;
}

const SharePopup: React.FC<Props> = (props) => {
  const theme = useAppSelector((state) => state.theme.theme);
  const [closePlayers, setClosePlayers] = useState<any>(null);
  const langauge = useAppSelector((state) => state.config.language);

  useEffect(() => {
    fetchNui('getNearbyPlayers')
      .then((data) => {
        setClosePlayers(data);
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);
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
      <div className="spitIntoGrids customHeight">
        <div className="top">
          <h1>{langauge.popouts.shareOutfitPopup.title}</h1>
          <h3 style={{ color: theme.text['grey-faded'], marginTop: 0 }}>
            {langauge.popouts.shareOutfitPopup.message}
          </h3>
        </div>
        <div className="middle" style={{ color: theme.text['white'] }}>
          {/* <h3>{langauge.popouts.shareOutfitPopup.message}</h3> */}
          {!closePlayers && (
            <h3>{langauge.popouts.shareOutfitPopup.noPlayers}</h3>
          )}
          {closePlayers &&
            closePlayers.map((player: any, index: number) => {
              if (index > 6) {
                return null;
              }
              return (
                <>
                  <div
                    className="playerName"
                    onClick={() => {
                      // props.closeFunc(false);
                      sendNui('shareOutfit', {
                        player: player.source,
                        outfit: props.currentOutfit,
                      });
                    }}
                    onMouseEnter={(e) => {
                      e.currentTarget.style.backgroundColor =
                        theme.sidebar['nameHover'];
                    }}
                    onMouseLeave={(e) => {
                      e.currentTarget.style.backgroundColor =
                        theme.background['clothing-main'];
                    }}
                  >
                    {player.name} ({player.source})
                  </div>
                </>
              );
            })}
        </div>
        <div className="bottom">
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

export default SharePopup;
