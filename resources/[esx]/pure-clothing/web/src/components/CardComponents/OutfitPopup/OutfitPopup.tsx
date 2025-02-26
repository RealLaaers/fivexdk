import React, { useState } from 'react';
import { useAppSelector } from '../../../store/store';
import './OutfitPopup.scss';
import { sendNui } from '../../../utils/sendNui';

interface Props {
  func: any;
}

const OutfitPopup: React.FC<Props> = (props) => {
  const [outfitName, setOutfitName] = useState<string>('');
  const theme = useAppSelector((state) => state.theme.theme);
  const language = useAppSelector((state) => state.config.language);

  const saveOutfits = (name: string) => {
    // console.log(name, 'saved outfit');
    sendNui('saveOutfit', name);
    props.func(false);
  };

  return (
    <>
      <section
        className="popup"
        style={{
          backgroundColor: theme.background['clothing-main'],
          borderRadius: theme.borders['border-radius'],
          color: theme.text['white'],
          boxShadow: theme.background['box-shadow'],
        }}
      >
        <div>
          <h1>{language.popouts.createOutfit}</h1>
        </div>
        <div className="middle">
          <input
            type="text"
            id="outfitCreation"
            placeholder={language.general.name}
            required
            onInput={(e) => {
              setOutfitName(e.currentTarget.value);
            }}
            style={{
              borderBottom:
                theme.borders['border-thin'] +
                ' ' +
                theme.borders['border-colour'],
              color: theme.text['white'],
            }}
            onFocus={(e) => {
              e.currentTarget.style.borderBottom =
                theme.borders['border-thin'] +
                ' ' +
                theme.mainColourway['main-colour'];
            }}
            onBlur={(e) => {
              e.currentTarget.style.borderBottom =
                theme.borders['border-thin'] +
                ' ' +
                theme.borders['border-colour'];
            }}
          />
        </div>
        <div className="bottom">
          <div
            className="ripple-animation button cancel"
            onClick={() => props.func(false)}
            style={{
              backgroundColor: theme.sidebar['delete'],
            }}
          >
            {language.general.cancel}
          </div>
          <div
            className="ripple-animation button save"
            onClick={() => {
              saveOutfits(outfitName);
            }}
            style={{
              backgroundColor: theme.sidebar['save'],
            }}
          >
            {language.general.save}
          </div>
        </div>
      </section>
    </>
  );
};

export default OutfitPopup;
