import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import {
  setShape,
  setWidth,
} from '../../../../store/features/createChar/jawSlice';

const Jaw: React.FC = () => {
  const dispatch = useAppDistpatch();
  const state = useAppSelector((state) => state.jaw);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].jaw) {
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
      case 'jaw-bone-width':
        dispatch(setWidth(parseInt(value)));
        break;
      case 'jaw-bone-shape':
        dispatch(setShape(parseInt(value)));
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
        <h1>{language.menus.createCharacter.jawTitle}</h1>
        <p>
          <svg
            version="1.1"
            x="0px"
            y="0px"
            viewBox="0 0 512 512"
            fill="currentColor"
          >
            <path
              d="M393.973,89.572c-35.571-18.701-73.549-15.353-109.875,9.636l-3.646,2.522c-13.408,9.288-14.207,9.843-24.451,9.843
      c-10.244,0-11.044-0.554-24.451-9.843l-3.652-2.522c-36.315-24.995-74.31-28.32-109.87-9.636C46.777,127.036,0,250.703,0,261.834
      c0,1.946,0.629,4.53,0.609,4.457C1.06,267.97,48.049,434.355,256,434.355S510.94,267.97,511.391,266.29
      c0.298-1.112,0.609-3.085,0.609-4.457C512,250.703,465.267,127.06,393.973,89.572z M294.293,270.604
      c-11.664,6.18-24.87,9.445-38.191,9.445c-0.027,0-0.06,0-0.087,0c-0.049-0.011-0.076-0.006-0.119,0
      c-13.321,0-26.527-3.267-38.185-9.44c-18.155-9.626-36.365-16.451-54.539-20.628c24.324-17.703,45.243-27.454,58.913-27.454
      c10.582,0,17.331,5.245,19.772,7.533c0.494,0.739,1.049,1.451,1.668,2.125c5.587,6.054,14.767,7.13,21.576,2.532
      c1.337-0.897,2.543-2.006,3.576-3.256l0.006,0.006c0.315-0.364,7.805-8.94,21.228-8.94c13.667,0.001,34.577,9.746,58.889,27.442
      C330.681,254.145,312.459,260.973,294.293,270.604z"
            />
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
              handleSliderChange(value, 'jaw-bone-width');
            }}
          />
        </div>
        <div className="sliderRow">
          <h2
            style={{
              color: theme.text['white'],
            }}
          >
            {language.menus.createCharacter.general.boneShape}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.shape}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'jaw-bone-shape');
            }}
          />
        </div>
      </ThemeProvider>
      <div className="margin-top"></div>
    </div>
  );
};

export default Jaw;
