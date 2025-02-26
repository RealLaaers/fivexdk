import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import {
  setDepth,
  setHeight,
  setWidth,
} from '../../../../store/features/createChar/cheekSlice';

const Cheek: React.FC = () => {
  const dispatch = useAppDistpatch();
  const state = useAppSelector((state) => state.cheek);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].cheek) {
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
    switch (context) {
      case 'cheek-depth':
        dispatch(setDepth(parseInt(value)));
        break;
      case 'cheek-height':
        dispatch(setHeight(parseInt(value)));
        break;
      case 'cheek-width':
        dispatch(setWidth(parseInt(value)));
        break;
      default:
        break;
    }
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
        <h1>{language.menus.createCharacter.cheekTitle}</h1>
        <p>
          <svg
            viewBox="0 0 512 512"
            fill="currentColor"
            height="1em"
            width="1em"
          >
            <path d="M256 512c141.4 0 256-114.6 256-256S397.4 0 256 0 0 114.6 0 256s114.6 256 256 256zm127.8-194.2c12.3-3.7 24.3 7 19.2 18.7-24.5 56.9-81.1 96.7-147 96.7s-122.5-39.8-147-96.7c-5.1-11.8 6.9-22.4 19.2-18.7C166.7 329.4 210.1 336 256 336s89.3-6.6 127.8-18.2zm-166.2-89l-.2-.2c-.2-.2-.4-.5-.7-.9-.6-.8-1.6-2-2.8-3.4-2.5-2.8-6-6.6-10.2-10.3-8.8-7.8-18.8-14-27.7-14s-18.9 6.2-27.7 14c-4.2 3.7-7.7 7.5-10.2 10.3-1.2 1.4-2.2 2.6-2.8 3.4-.3.4-.6.7-.7.9l-.2.2c-2.1 2.8-5.7 3.9-8.9 2.8s-5.5-4.1-5.5-7.6c0-17.9 6.7-35.6 16.6-48.8 9.8-13 23.9-23.2 39.4-23.2s29.6 10.2 39.4 23.2c9.9 13.2 16.6 30.9 16.6 48.8 0 3.4-2.2 6.5-5.5 7.6s-6.9 0-8.9-2.8zm160 0l-.2-.2c-.2-.2-.4-.5-.7-.9-.6-.8-1.6-2-2.8-3.4-2.5-2.8-6-6.6-10.2-10.3-8.8-7.8-18.8-14-27.7-14s-18.9 6.2-27.7 14c-4.2 3.7-7.7 7.5-10.2 10.3-1.2 1.4-2.2 2.6-2.8 3.4-.3.4-.6.7-.7.9l-.2.2c-2.1 2.8-5.7 3.9-8.9 2.8s-5.5-4.1-5.5-7.6c0-17.9 6.7-35.6 16.6-48.8 9.8-13 23.9-23.2 39.4-23.2s29.6 10.2 39.4 23.2c9.9 13.2 16.6 30.9 16.6 48.8 0 3.4-2.2 6.5-5.5 7.6s-6.9 0-8.9-2.8z" />
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
            {language.menus.createCharacter.general.boneDepth}
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
              handleSliderChange(value, 'cheek-depth');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.boneHeight}
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
              handleSliderChange(value, 'cheek-height');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.boneWidth}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.width}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'cheek-width');
            }}
          />
        </div>
      </ThemeProvider>
      <div className="margin-top"></div>
    </div>
  );
};

export default Cheek;
