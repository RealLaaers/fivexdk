import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import { setOpening } from '../../../../store/features/createChar/eyesSlice';
import EyeColourPicker from '../../../CardComponents/EyeColourPicker/EyeColourPicker';

const Eyes: React.FC = () => {
  const dispatch = useAppDistpatch();
  const state = useAppSelector((state) => state.eyes);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].eyes) {
    return null;
  }

  const language = useAppSelector((state) => state.config.language);

  const theme = useAppSelector((state) => state.theme.theme);
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

  const handleSliderChange = (value: any, context: string) => {
    // console.log(value, context);
    switch (context) {
      case 'eyes-opening':
        dispatch(setOpening(parseInt(value)));
        break;
      default:
        break;
    }
    // props.handleSliderChangeFunc(value, context);
  };

  return (
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
        <h1>{language.menus.createCharacter.eyeTitle}</h1>
        <p>
          <svg
            viewBox="0 0 1024 1024"
            fill="currentColor"
            height="1em"
            width="1em"
          >
            <path d="M396 512a112 112 0 10224 0 112 112 0 10-224 0zm546.2-25.8C847.4 286.5 704.1 186 512 186c-192.2 0-335.4 100.5-430.2 300.3a60.3 60.3 0 000 51.5C176.6 737.5 319.9 838 512 838c192.2 0 335.4-100.5 430.2-300.3 7.7-16.2 7.7-35 0-51.5zM508 688c-97.2 0-176-78.8-176-176s78.8-176 176-176 176 78.8 176 176-78.8 176-176 176z" />
          </svg>
        </p>
      </div>
      <div className="margin-top"></div>
      <ThemeProvider theme={SliderTheme}>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.opening}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.opening}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'eyes-opening');
            }}
          />
        </div>
      </ThemeProvider>
      <EyeColourPicker />
      <div className="margin-top"></div>
    </div>
  );
};

export default Eyes;
