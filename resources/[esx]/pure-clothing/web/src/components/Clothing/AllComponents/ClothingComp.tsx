import React, { useEffect, useState } from 'react';
import { useAppSelector } from '../../../store/store';
import updateRipples from '../../../utils/updateRipple';
import '../../Component.scss';

interface clothingProps {
  headingName: string;
  nameOfState: string;
  handleClickFunc: (id: string, math: number) => void;
  icon: any;
  id_1: string;
  id_2: string;
  isProps: boolean;
}

const ClothingComp: React.FC<clothingProps> = (props) => {
  const svgElement = React.createElement(
    'svg',
    {
      viewBox: props.icon.viewBox,
      fill: 'currentColor',
      height: '1em',
      width: '1em',
    },
    React.createElement('path', {
      d: props.icon.d,
    })
  );

  const stateName: string = props.nameOfState;
  const states = useAppSelector((state: any) => state[stateName]);
  const config = useAppSelector((state) => state.config.config);
  const language = useAppSelector((state) => state.config.language);
  const languageName = language.menus.clothingNames[stateName];

  const disabledMenuForPeds = useAppSelector(
    (state: any) => state.config.disabledMenusForPed
  );
  if (
    disabledMenuForPeds &&
    config.nui.whenPedDisableUneededMenus &&
    states.maxValue1 === -1
  ) {
    return null;
  }

  if (props.isProps) {
    if (!config.nui['sections']['props'][stateName]) {
      return null;
    }
  } else {
    if (!config.nui['sections']['clothing'][stateName]) {
      return null;
    }
  }

  const [focused, setFocused] = useState(false);

  const theme = useAppSelector((state) => state.theme.theme);

  const handleClick = (id: string, math: number) => {
    props.handleClickFunc(id, math);
  };

  useEffect(() => {
    updateRipples();
  }, []);

  return (
    <>
      <div
        className="mainComponent auto-height"
        style={{
          backgroundColor: theme.background['clothing-main'],
          // border:
          //   theme.borders['border-thick'] +
          //   ' ' +
          //   theme.borders['border-colour'],
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
          <h1>{languageName}</h1>
          <p>{svgElement}</p>
        </div>
        <div
          className="divider"
          style={{
            color: theme.text['white'],
          }}
        >
          <div>
            <h2>
              {states.maxValue1} {language.general.models}
            </h2>
            <div className="chevrons">
              <h3
                className="ripple-animation"
                onClick={() => {
                  handleClick(props.id_1, -1);
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'<'}
              </h3>
              <input
                type="number"
                value={states.baseValue1}
                onChange={(e: any) => {
                  handleClick(props.id_1 + '_input', parseInt(e.target.value));
                }}
                style={{
                  color: theme.text['white'],
                  borderBottom:
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.borders['border-colour'],
                }}
                onFocus={(e) => {
                  setFocused(true);
                  e.currentTarget.style.borderBottom =
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.mainColourway['main-colour'];
                  e.target.addEventListener(
                    'wheel',
                    function (e) {
                      e.preventDefault();
                    },
                    { passive: false }
                  );
                }}
                onBlur={(e) => {
                  setFocused(false);
                  e.currentTarget.style.borderBottom =
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.borders['border-colour'];
                }}
                onWheel={(e) => {
                  if (!focused) {
                    return;
                  }
                  if (e.deltaY > 0) {
                    handleClick(props.id_1, -1);
                  } else {
                    handleClick(props.id_1, 1);
                  }
                }}
              />
              <h3
                className="ripple-animation"
                onClick={() => {
                  handleClick(props.id_1, +1);
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'>'}
              </h3>
            </div>
          </div>
          <div>
            <h2>
              {states.maxValue2} {language.general.variations}
            </h2>
            <div className="chevrons">
              <h3
                className="ripple-animation"
                onClick={() => {
                  handleClick(props.id_2, -1);
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'<'}
              </h3>
              <input
                type="number"
                value={states.baseValue2}
                onChange={(e: any) => {
                  handleClick(props.id_2 + '_input', parseInt(e.target.value));
                }}
                style={{
                  color: theme.text['white'],
                  borderBottom:
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.borders['border-colour'],
                }}
                onFocus={(e) => {
                  setFocused(true);
                  e.currentTarget.style.borderBottom =
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.mainColourway['main-colour'];
                  e.target.addEventListener(
                    'wheel',
                    function (e) {
                      e.preventDefault();
                    },
                    { passive: false }
                  );
                }}
                onBlur={(e) => {
                  setFocused(false);
                  e.currentTarget.style.borderBottom =
                    theme.borders['border-thin'] +
                    ' ' +
                    theme.borders['border-colour'];
                }}
                onWheel={(e) => {
                  if (!focused) {
                    return;
                  }
                  if (e.deltaY > 0) {
                    handleClick(props.id_2, -1);
                  } else {
                    handleClick(props.id_2, 1);
                  }
                }}
              />
              <h3
                className="ripple-animation"
                onClick={() => {
                  handleClick(props.id_2, 1);
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'>'}
              </h3>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ClothingComp;
