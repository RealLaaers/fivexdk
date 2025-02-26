import React from 'react';
import Slider from '@mui/material/Slider';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import '../../../Component.scss';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import { setThickness } from '../../../../store/features/createChar/neckSlice';

const Neck: React.FC = () => {
  const dispatch = useAppDistpatch();
  const theme = useAppSelector((state) => state.theme.theme);
  const state = useAppSelector((state) => state.neck);
  const config = useAppSelector((state) => state.config.config);

  if (!config.nui['sections']['faceStructure'].neck) {
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

  const handleSliderChange = (value: any, context: string) => {
    switch (context) {
      case 'neck-thickness':
        dispatch(setThickness(parseInt(value)));
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
        <h1>{language.menus.createCharacter.neckTitle}</h1>
        <p>
          <svg
            version="1.1"
            fill="currentColor"
            x="0px"
            y="0px"
            viewBox="0 0 297.09 297.09"
          >
            <g>
              <path
                d="M241.859,199.72l-36.284-6.914c-10.289-1.961-18.219-9.725-20.695-19.507c-11.495,10.224-24.319,15.651-37.592,15.651
    c-12.506,0-24.613-4.821-35.586-13.929c-2.931,8.96-10.511,15.941-20.187,17.785l-36.284,6.914
    c-19.131,3.646-32.473,21.077-30.996,40.497l3.439,45.2c0.501,6.586,5.991,11.673,12.595,11.673h216.552
    c6.604,0,12.094-5.088,12.595-11.673l3.439-45.2C274.332,220.798,260.99,203.366,241.859,199.72z M131.675,233.149
    c-0.956,0.564-2.005,0.832-3.04,0.832c-2.056,0-4.057-1.057-5.175-2.955c-1.098-1.861-3.038-3.074-5.192-3.244l-46.434-3.654
    c-3.304-0.26-5.771-3.148-5.511-6.452c0.26-3.304,3.152-5.77,6.452-5.511l46.434,3.654c6.053,0.477,11.507,3.884,14.589,9.115
    C135.48,227.789,134.53,231.467,131.675,233.149z M225.256,224.127l-46.433,3.654c-2.154,0.17-4.096,1.383-5.193,3.244
    c-1.118,1.898-3.12,2.955-5.175,2.955c-1.035,0-2.084-0.268-3.04-0.832c-2.855-1.682-3.806-5.36-2.123-8.215
    c3.082-5.231,8.537-8.639,14.59-9.115l46.433-3.654c3.305-0.261,6.192,2.207,6.452,5.511
    C231.026,220.979,228.559,223.868,225.256,224.127z"
              />
              <path
                d="M147.288,173.95c34.597,0,62.644-54.694,62.644-97.124C209.932,34.396,181.886,0,147.288,0
    c-34.597,0-62.644,34.396-62.644,76.826C84.644,119.256,112.691,173.95,147.288,173.95z M103.643,79.961
    c-4.142,0-7.5-3.358-7.5-7.5s3.358-7.5,7.5-7.5s7.5,3.358,7.5,7.5S107.785,79.961,103.643,79.961z M109.344,59.898
    c-0.925,0-1.863-0.172-2.774-0.535c-3.848-1.533-5.725-5.896-4.19-9.743c8.454-21.217,25.242-33.884,44.909-33.884
    c4.143,0,7.5,3.357,7.5,7.5s-3.357,7.5-7.5,7.5c-13.497,0-24.787,8.906-30.975,24.436
    C115.142,58.109,112.323,59.898,109.344,59.898z"
              />
            </g>
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
            {language.menus.createCharacter.general.thickness}
          </h2>
          <Slider
            style={{ width: '12em' }}
            size="medium"
            value={state.thickness}
            aria-label="Small"
            valueLabelDisplay="auto"
            step={1}
            min={0}
            max={100}
            onChange={(e: any, value, activeThumb) => {
              handleSliderChange(value, 'neck-thickness');
            }}
          />
        </div>
      </ThemeProvider>
      <div className="margin-top"></div>
    </div>
  );
};

export default Neck;
