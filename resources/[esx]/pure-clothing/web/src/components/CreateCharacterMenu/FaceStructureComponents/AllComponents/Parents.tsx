import React, { useEffect, useState } from 'react';
import Slider from '@mui/material/Slider';
import { useAppSelector, useAppDistpatch } from '../../../../store/store';
import {
  setMotherValue,
  setFatherValue,
  setSimilarity,
  setSkinColour,
  setMotherValueByInput,
  setFatherValueByInput,
  setGender,
} from '../../../../store/features/createChar/parentsSlice';
import { setCurrentPed } from '../../../../store/features/createChar/pedsSlice';
import updateRipples from '../../../../utils/updateRipple';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';

const Parents: React.FC = () => {
  const dispatch = useAppDistpatch();
  const parentsState = useAppSelector((state) => state.parents);
  const theme = useAppSelector((state) => state.theme.theme);
  const config = useAppSelector((state) => state.config.config);
  const [focused, setFocused] = useState(false);

  if (!config.nui['sections']['faceStructure'].parents) {
    return null;
  }

  const language = useAppSelector((state) => state.config.language);

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

  const genderSet = (gender: string) => {
    dispatch(setGender(gender));
    if (gender == 'male') {
      dispatch(setCurrentPed('mp_m_freemode_01'));
    } else {
      dispatch(setCurrentPed('mp_f_freemode_01'));
    }
  };

  const handleSliderChange = (value: any, context: string) => {
    // console.log(value, context);
    // props.handleSliderChangeFunc(value, context);
    switch (context) {
      case 'mother':
        dispatch(setMotherValue(parseInt(value)));
        break;
      case 'father':
        dispatch(setFatherValue(parseInt(value)));
        break;
      case 'similarity':
        dispatch(setSimilarity(parseInt(value)));
        break;
      case 'skinColour':
        dispatch(setSkinColour(parseInt(value)));
        break;
      default:
        break;
    }
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
          <h1>{language.menus.createCharacter.parents.title}</h1>
          <p>
            <svg
              fill="none"
              viewBox="0 0 24 24"
              height="1em"
              width="1em"
              style={{
                color:
                  (parentsState.gender === 'male' &&
                    theme.mainColourway['main-colour']) ||
                  theme.text['text-like-borders'],
              }}
              onClick={() => {
                genderSet('male');
              }}
            >
              <path
                fill="currentColor"
                fillRule="evenodd"
                d="M12.189 7l.002-2 7 .007-.008 7-2-.002.004-3.588-3.044 3.044a5.002 5.002 0 01-7.679 6.336 5 5 0 016.25-7.736l3.058-3.057L12.189 7zm-4.31 5.14a3 3 0 114.242 4.244A3 3 0 017.88 12.14z"
                clipRule="evenodd"
                strokeWidth="0.4"
                stroke="currentColor"
              />
            </svg>
            <svg
              fill="none"
              viewBox="0 0 24 24"
              height="1em"
              width="1em"
              onClick={() => {
                genderSet('female');
              }}
              style={{
                color:
                  (parentsState.gender === 'female' &&
                    theme.mainColourway['main-colour']) ||
                  theme.text['text-like-borders'],
              }}
            >
              <path
                fill="currentColor"
                fillRule="evenodd"
                d="M12 3a5 5 0 00-1 9.9V15H8v2h3v4h2v-4h3v-2h-3v-2.1A5.002 5.002 0 0012 3zM9 8a3 3 0 106 0 3 3 0 00-6 0z"
                clipRule="evenodd"
                strokeWidth="0.4"
                stroke="currentColor"
              />
            </svg>
          </p>
        </div>
        <div
          className="divider"
          style={{
            color: theme.text['white'],
          }}
        >
          <div>
            <h2>
              {parentsState.motherMaxValue} -{' '}
              {language.menus.createCharacter.parents.mother}
            </h2>
            <div className="chevrons">
              <h3
                className="ripple-animation"
                onClick={() => {
                  //   handleClick(props.id_1, -1);
                  handleSliderChange(-1, 'mother');
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'<'}
              </h3>
              <input
                type="number"
                value={parentsState.motherValue}
                onChange={(e: any) => {
                  dispatch(setMotherValueByInput(parseInt(e.target.value)));
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
                    handleSliderChange(-1, 'mother');
                  } else {
                    handleSliderChange(1, 'mother');
                  }
                }}
              />
              <h3
                className="ripple-animation"
                onClick={() => {
                  //   handleClick(props.id_1, +1);
                  handleSliderChange(1, 'mother');
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
              {parentsState.fatherMaxValue} -{' '}
              {language.menus.createCharacter.parents.father}
            </h2>
            <div className="chevrons">
              <h3
                className="ripple-animation"
                onClick={() => {
                  //   handleClick(props.id_2, -1);
                  handleSliderChange(-1, 'father');
                }}
                style={{
                  backgroundColor: theme.mainColourway['main-colour'],
                }}
              >
                {'<'}
              </h3>
              <input
                type="number"
                value={parentsState.fatherValue}
                onChange={(e: any) => {
                  dispatch(setFatherValueByInput(parseInt(e.target.value)));
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
                    handleSliderChange(-1, 'father');
                  } else {
                    handleSliderChange(1, 'father');
                  }
                }}
              />
              <h3
                className="ripple-animation"
                onClick={() => {
                  //   handleClick(props.id_2, 1);
                  handleSliderChange(1, 'father');
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
        <div
          className="sliderComp"
          style={{
            color: theme.sidebar['info'],
          }}
        >
          <ThemeProvider theme={SliderTheme}>
            <Slider
              style={{ width: '23.59em', left: '0.9em' }}
              size="medium"
              value={parentsState.similarity}
              aria-label="Small"
              valueLabelDisplay="auto"
              step={1}
              min={0}
              max={100}
              className="slider"
              onChange={(e: any, value, activeThumb) => {
                handleSliderChange(value, 'similarity');
              }}
            />
            <div className="margin-top"></div>
            <Slider
              style={{ width: '23.59em', left: '0.9em' }}
              size="medium"
              value={parentsState.skinColour}
              aria-label="Small"
              valueLabelDisplay="auto"
              step={1}
              min={0}
              max={100}
              onChange={(e: any, value, activeThumb) => {
                handleSliderChange(value, 'skinColour');
              }}
            />
          </ThemeProvider>
        </div>
      </div>
    </>
  );
};

export default Parents;
