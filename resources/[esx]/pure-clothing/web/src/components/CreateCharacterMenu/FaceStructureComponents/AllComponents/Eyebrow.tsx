import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import {
  setDepth,
  setHeight,
} from '../../../../store/features/createChar/eyebrowSlice';

const Eyebrow: React.FC = () => {
  const dispatch = useAppDistpatch();
  const state = useAppSelector((state) => state.eyebrow);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].eyebrow) {
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
      case 'eyebrow-depth':
        dispatch(setDepth(parseInt(value)));
        break;
      case 'eyebrow-height':
        dispatch(setHeight(parseInt(value)));
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
        <h1>{language.menus.createCharacter.eyebrowTitle}</h1>
        <p>
          <svg width="800px" height="800px" viewBox="0 0 24 24" version="1.1">
            <path
              d="M18.9372,9.36167 C20.6395,10.1301 22.108,11.2831 22.8998,12.9158 C23.0681,13.2628 23.0219,13.6757 22.781,13.9769 C22.5401,14.278 22.1474,14.4138 21.772,14.3258 C15.8145,12.93 9.78907,15.3311 6.61118,16.6414 C4.618,17.4633 2.68113,16.7923 1.68066,15.44 C1.18289,14.7672 0.915929,13.9186 1.02369,13.0307 C1.36416,10.2254 4.88953,9.02468 7.21626,8.49728 C10.9972,7.64025 15.3643,7.74879 18.9372,9.36167 Z"
              id="路径"
              fill="currentColor"
            ></path>
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
            {language.menus.createCharacter.general.depth}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.depth}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'eyebrow-depth');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.height}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.height}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'eyebrow-height');
            }}
          />
        </div>
      </ThemeProvider>
      <div className="margin-top"></div>
    </div>
  );
};

export default Eyebrow;
