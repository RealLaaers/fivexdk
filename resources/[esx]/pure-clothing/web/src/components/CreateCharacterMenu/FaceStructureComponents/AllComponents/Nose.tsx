import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import {
  setWidth,
  setPeak,
  setLength,
  setCurveness,
  setTip,
  setTwist,
} from '../../../../store/features/createChar/noseSlice';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';

const Nose: React.FC = () => {
  const dispatch = useAppDistpatch();
  const state = useAppSelector((state) => state.nose);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].nose) {
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
      case 'nose-width':
        dispatch(setWidth(parseInt(value)));
        break;
      case 'nose-peak':
        dispatch(setPeak(parseInt(value)));
        break;
      case 'nose-length':
        dispatch(setLength(parseInt(value)));
        break;
      case 'bone-curveness':
        dispatch(setCurveness(parseInt(value)));
        break;
      case 'nose-tip':
        dispatch(setTip(parseInt(value)));
        break;
      case 'nose-bone-twist':
        dispatch(setTwist(parseInt(value)));
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
        <h1>{language.menus.createCharacter.noseTitle}</h1>
        <p>
          <svg width="800px" height="800px" viewBox="0 0 24 24" version="1.1">
            <path
              d="M7.27024,7.26736 C7.74507,5.09566 10,2 12,2 C14,2 16.255,5.09558 16.7298,7.26738 C16.9791,8.40783 17.3722,9.50838 17.8944,10.5528 C18.9068,12.5775 21,14.0425 21,16.5 C21,18.433 19.433,20 17.5,20 C16.9243,20 15.9804,19.6279 15.4472,19.8944 C15.0522,20.0919 14.7847,20.561 14.4901,20.8735 C13.9709,21.4242 13.2259,22 12,22 C10.7741,22 10.0291,21.4242 9.50991,20.8735 C9.21526,20.561 8.94781,20.0919 8.55279,19.8944 C8.01965,19.6279 7.07575,20 6.5,20 C4.567,20 3,18.433 3,16.5 C3,14.0425 5.09321,12.5775 6.10557,10.5528 C6.62778,9.50838 7.02088,8.40781 7.27024,7.26736 Z"
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
            {language.menus.createCharacter.general.width}
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
              handleSliderChange(value, 'nose-width');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.peak}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.peak}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'nose-peak');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.length}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.length}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'nose-length');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.boneCurve}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.curveness}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'bone-curveness');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.tip}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.tip}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'nose-tip');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.boneTwist}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.twist}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'nose-bone-twist');
            }}
          />
        </div>
      </ThemeProvider>
      <div className="margin-top"></div>
    </div>
  );
};

export default Nose;
