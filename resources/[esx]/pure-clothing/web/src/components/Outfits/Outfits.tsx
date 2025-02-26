import React, { Suspense, useState } from 'react';
import { useAppSelector } from '../../store/store';
const OutfitPopup = React.lazy(
  () => import('../CardComponents/OutfitPopup/OutfitPopup')
);
// import OutfitComponent from './OutfitComponent/OutfitComponent';
const OutfitComponent = React.lazy(
  () => import('./OutfitComponent/OutfitComponent')
);
const DeleteOutfitPopup = React.lazy(
  () => import('./DeleteOutfitPopup/DeleteOutfitPopup')
);
import '../Component.scss';
import './Outfit.scss';
import { sendNui } from '../../utils/sendNui';
import SharePopup from './SharePopup/SharePopup';
import { useNuiEvent } from '../../hooks/useNuiEvent';
import AcceptPopup from './AcceptPopup/AcceptPopup';

const Outfits: React.FC = () => {
  const [outfitPopup, setOutfitPopup] = useState(false);
  const [sharePopup, setSharePopup] = useState(false);
  const [acceptOutfit, setAcceptOutfit] = useState(false);
  const [deleteOutfit, setDeleteOutfit] = useState(false);
  const [selectedOutfit, setSelectedOutfit] = useState<any>(null);
  const theme = useAppSelector((state) => state.theme.theme);
  const outfits = useAppSelector((state) => state.outfit);
  const myOutfits = outfits.currentOutfits;
  const configOutfits = outfits.configOutfits;

  const useCurrentOutfit = (uniqueOutfitid: string) => {
    const outfit = myOutfits.find(
      (outfit) => outfit.uniqueOutfitid === uniqueOutfitid
    );
    if (outfit) {
      // console.log(outfit);
      sendNui('useCurrentOutfit', outfit);
    }
  };
  const useConfigOutfit = (uniqueOutfitid: string) => {
    const outfit = configOutfits.find(
      (outfit) => outfit.uniqueOutfitid === uniqueOutfitid
    );
    if (outfit) {
      // console.log(outfit);
      sendNui('useConfigOutfit', outfit);
    }
  };
  const shareCurrentOutfit = (uniqueOutfitid: string) => {
    const outfit = myOutfits.find(
      (outfit) => outfit.uniqueOutfitid === uniqueOutfitid
    );
    if (outfit) {
      // console.log(outfit);
      setSharePopup(true);
      setSelectedOutfit(outfit);
    }
  };
  const deleteCurrentOutfit = (uniqueOutfitid: string) => {
    const outfit = myOutfits.find(
      (outfit) => outfit.uniqueOutfitid === uniqueOutfitid
    );
    if (outfit) {
      // console.log(outfit);
      setSelectedOutfit(outfit);
      // sendNui('deleteCurrentOutfit', outfit);
    }
  };

  useNuiEvent('giveOutfit', (outfit: any) => {
    // console.log(outfit);
    setAcceptOutfit(true);
    setSelectedOutfit(outfit);
  });

  const langauge = useAppSelector((state) => state.config.language);

  return (
    <>
      {outfitPopup && (
        <Suspense fallback={<h1>Loading...</h1>}>
          <OutfitPopup func={setOutfitPopup} />
        </Suspense>
      )}
      {sharePopup && (
        <Suspense fallback={<h1>Loading...</h1>}>
          <SharePopup
            closeFunc={setSharePopup}
            currentOutfit={selectedOutfit}
          />
        </Suspense>
      )}
      {acceptOutfit && (
        <Suspense fallback={<h1>Loading...</h1>}>
          <AcceptPopup
            closeFunc={setAcceptOutfit}
            currentOutfit={selectedOutfit}
          />
        </Suspense>
      )}
      {deleteOutfit && (
        <Suspense fallback={<h1>Loading...</h1>}>
          <DeleteOutfitPopup
            closeFunc={setDeleteOutfit}
            currentOutfit={selectedOutfit}
          />
        </Suspense>
      )}
      <div className="mainComponent">
        <div className="icon-top">
          <svg
            viewBox="0 0 512 512"
            fill="currentColor"
            height="1em"
            width="1em"
            onClick={() => setOutfitPopup(true)}
            style={{
              backgroundColor: theme.background['clothing-top-block'],
              color: theme.text['white'],
            }}
          >
            <path
              fill="none"
              stroke="currentColor"
              strokeLinecap="square"
              strokeLinejoin="round"
              strokeWidth={120}
              d="M256 112v288M400 256H112"
            />
          </svg>
        </div>
        <section>
          {myOutfits.length > 0 && (
            <h2
              style={{
                color: theme.text['white'],
              }}
            >
              {langauge.menus.outfits.yourOutfits}
            </h2>
          )}
          {myOutfits.map((outfit, index) => {
            return (
              <OutfitComponent
                key={outfit.uniqueOutfitid}
                name={outfit.name}
                id={index + 1}
                isDisabled={false}
                uniqueOutfitid={outfit.uniqueOutfitid}
                useOutfit={useCurrentOutfit}
                currentClicked={shareCurrentOutfit}
                deleteOutfit={deleteCurrentOutfit}
                setDeleteOutfit={setDeleteOutfit}
              />
            );
          })}
          {configOutfits.length > 0 && (
            <h2
              style={{
                color: theme.text['white'],
              }}
            >
              {langauge.menus.outfits.preSet}
            </h2>
          )}
          {configOutfits.map((outfit) => {
            // console.log(outfit.uniqueOutfitid);
            return (
              <OutfitComponent
                key={outfit.id}
                name={outfit.name}
                id={outfit.id}
                isDisabled={true}
                uniqueOutfitid={outfit.uniqueOutfitid}
                useOutfit={useConfigOutfit}
                currentClicked={() => {
                  // make this not do anything
                }}
                deleteOutfit={() => {
                  // make this not do anything
                }}
                setDeleteOutfit={() => {
                  // make this not do anything
                }}
              />
            );
          })}
        </section>
      </div>
    </>
  );
};

export default Outfits;
