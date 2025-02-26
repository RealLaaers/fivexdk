import React, { useState } from 'react';
import { useAppSelector } from '../../../../store/store';
import '../../../Component.scss';

interface Props {
  setCurrentClicked: (clicked: string) => void;
}

const CustomPed: React.FC<Props> = (props) => {
  const [search, setSearch] = useState('');
  const theme = useAppSelector((state) => state.theme.theme);
  const language = useAppSelector((state) => state.config.language);

  return (
    <>
      <div
        className="mainComponent auto-height"
        style={{
          backgroundColor: theme.background['clothing-main'],
          border: theme.borders['border-main-complete'],
          boxShadow: theme.background['box-shadow'],
          borderRadius: theme.borders['border-radius'],
        }}
      >
        <div
          className="topBlock"
          style={{
            backgroundColor: theme.background['clothing-top-block'],
            color: theme.text['text-like-borders'],
          }}
        >
          <h1>{language.menus.peds.customPed}</h1>
          {/* <p>{svgElement}</p> */}
        </div>
        <div className="dropdownDivider auto-dropdown-height">
          <div style={{ paddingTop: 3, paddingBottom: 5 }}>
            <div className="dropDownBar">
              <input
                type="text"
                id="customPed"
                placeholder={language.menus.peds.customPedPlaceholder}
                className="inputText"
                onChange={(e) => {
                  setSearch(e.target.value.toLowerCase());
                }}
                onKeyPress={(e) => {
                  if (e.key === 'Enter') {
                    props.setCurrentClicked(search);
                  }
                }}
                style={{
                  color: theme.text['white'],
                  transition: '0.4s',
                  borderBottom:
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.dropdownDivider['border-colour'],
                }}
                onFocus={(e) => {
                  const element = document.getElementById('customPed');
                  if (element) {
                    element.style.borderBottom =
                      theme.borders['border-thin'] +
                      ' ' +
                      theme.mainColourway['main-colour'];
                  }
                }}
                onBlur={(e) => {
                  const element = document.getElementById('customPed');
                  if (element) {
                    element.style.borderBottom =
                      theme.borders['border-thin'] +
                      ' ' +
                      theme.dropdownDivider['border-colour'];
                  }
                }}
              />
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default CustomPed;
