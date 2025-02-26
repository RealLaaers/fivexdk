import React, { useEffect, useState } from 'react';
import Slider from '@mui/material/Slider';
import ColourPicker from '../../CardComponents/ColourPicker/ColourPicker';
import { useAppSelector, useAppDistpatch } from '../../../store/store';
import {
  setHairBaseValue2,
  setHairBaseValue2ByInput,
} from '../../../store/features/hair/hairSlice';
import '../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import updateRipples from '../../../utils/updateRipple';
import MakeupColourPicker from '../../CardComponents/MakeupColourPicker/MakeupColourPicker';

interface hairComponentProps {
  headingName: string;
  nameOfState: string;
  handleClickFunc: (id: string, math: any, context: string) => void;
  icon: any;
  id_1: string;
  opacity: number;
  colourID_1: number;
  colourID_2: number;
  enableSlider: boolean;
  enableColourBoxes: boolean;
}

const HairComp: React.FC<hairComponentProps> = (props) => {
  const dispatch = useAppDistpatch();
  const handleClick = (id: string, math: any, context: string) => {
    props.handleClickFunc(id, math, context);
  };

  const blazeClick = (math: any, context: string) => {
    if (context === 'input') {
      dispatch(setHairBaseValue2ByInput(math));
    } else {
      dispatch(setHairBaseValue2(math));
    }
  };

  const stateName: string = props.nameOfState;
  const states = useAppSelector((state: any) => state[stateName]);
  const theme = useAppSelector((state) => state.theme.theme);
  const config = useAppSelector((state) => state.config.config);
  const [focused, setFocused] = useState(false);

  if (!config.nui['sections']['hair'][stateName]) {
    return null;
  }

  const language = useAppSelector((state) => state.config.language);
  const languageName = language.menus.hairNames[stateName];

  const SliderTheme = createTheme({
    components: {
      MuiSlider: {
        styleOverrides: {
          thumb: {
            color: theme.mainColourway['main-colour'],
            '&:hover': {
              // boxShadow: '0 0 0 13px #4452bd1f !important',
              boxShadow:
                '0 0 0 13px ' +
                theme.mainColourway['main-colour-faded'] +
                ' !important',
            },
          },
          track: {
            color: theme.mainColourway['main-colour'],
          },
          rail: {
            color: theme.text['text-like-borders'],
          },
          valueLabel: {
            color: theme.text['white'],
            fontFamily: 'Montserrat',
            fontWeight: 600,
            fontSize: '0.8em',
          },
        },
      },
    },
  });

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

  useEffect(() => {
    updateRipples();
  }, []);

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
        {' '}
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
                  handleClick(props.id_1, -1, 'id_1');
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
                onChange={() => {
                  // console.log('change');
                }}
                onInput={(e) => {
                  handleClick(
                    props.id_1 + '_input',
                    parseInt(e.currentTarget.value),
                    'id_1'
                  );
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
                    handleClick(props.id_1, -1, 'id_1');
                  } else {
                    handleClick(props.id_1, 1, 'id_1');
                  }
                }}
              />
              <h3
                className="ripple-animation"
                onClick={() => {
                  handleClick(props.id_1, 1, 'id_1');
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'>'}
              </h3>
            </div>
          </div>
          {props.enableSlider ? (
            <ThemeProvider theme={SliderTheme}>
              <div>
                <h2>{language.general.opacity}</h2>
                <Slider
                  style={{ width: '12em' }}
                  size="medium"
                  value={states.opacity}
                  aria-label="Small"
                  valueLabelDisplay="auto"
                  step={1}
                  min={0}
                  max={100}
                  onChange={(e: any, value, activeThumb) => {
                    // console.log(value, 'value');
                    handleClick(props.id_1, value, 'opacity');
                  }}
                />
              </div>
            </ThemeProvider>
          ) : (
            <div>
              <h2>
                {states.maxValue2} {language.general.variations}
              </h2>
              <div className="chevrons">
                <h3
                  className="ripple-animation"
                  onClick={() => {
                    blazeClick(-1, 'notinput');
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
                    blazeClick(parseInt(e.currentTarget.value), 'input');
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
                      blazeClick(-1, 'notinput');
                    } else {
                      blazeClick(1, 'notinput');
                    }
                  }}
                />
                <h3
                  className="ripple-animation"
                  onClick={() => {
                    blazeClick(1, 'notinput');
                  }}
                  style={{
                    backgroundColor: theme.mainColourway['main-colour'],
                  }}
                >
                  {'>'}
                </h3>
              </div>
            </div>
          )}
        </div>
        {props.enableColourBoxes ? (
          <>
            {' '}
            {props.headingName === 'Lipstick' ||
            props.headingName === 'Blush' ? (
              <>
                <div>
                  <MakeupColourPicker
                    headingName={languageName + ' ' + language.general.colour1}
                    nameOfState={stateName}
                    onClickFunc={handleClick}
                  />
                </div>
              </>
            ) : (
              <>
                <div>
                  <ColourPicker
                    headingName={languageName + ' ' + language.general.colour1}
                    nameOfState={stateName}
                    onClickFunc={handleClick}
                  />
                </div>
                {props.headingName === 'Hair' ||
                props.headingName === 'Makeup' ? (
                  <div>
                    <ColourPicker
                      headingName={
                        languageName + ' ' + language.general.colour2
                      }
                      nameOfState={stateName + 'colour2'}
                      onClickFunc={handleClick}
                    />
                  </div>
                ) : null}
              </>
            )}
          </>
        ) : null}
        <div className="margin-top"></div>
      </div>
    </>
  );
};

export default HairComp;
