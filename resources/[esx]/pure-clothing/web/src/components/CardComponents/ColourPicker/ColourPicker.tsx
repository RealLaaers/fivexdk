import React, { useState, useEffect } from 'react';
import { SlideDown } from 'react-slidedown';
import { useAppSelector } from '../../../store/store';
import hairColours from '../../../menus/hairColours';
import './ColourPicker.scss';
import '../CardComponents.scss';
import 'react-slidedown/lib/slidedown.css';

interface colourPickerProps {
  headingName: string;
  nameOfState: string;
  onClickFunc: (id: string, math: number, context: string) => void;
}

const ColourPicker: React.FC<colourPickerProps> = (props) => {
  const [expanded, setExpanded] = useState(false);
  const theme = useAppSelector((state) => state.theme.theme);
  let states = useAppSelector((state: any) => state[props.nameOfState]);
  let colourID = 1;
  if (props.nameOfState === 'makeupcolour2') {
    states = useAppSelector((state: any) => state['makeup']);
    colourID = states.colourID2;
  } else if (props.nameOfState === 'haircolour2') {
    states = useAppSelector((state: any) => state['hair']);
    colourID = states.colourID2;
  } else {
    colourID = states.colourID1;
  }

  useEffect(() => {
    // updateRipples();
    const buttonRipples: any = document.querySelectorAll(
      '.ripple-animation-tickbox'
    );

    buttonRipples.forEach((button: any) => {
      button.onclick = () => {
        const x = 23;
        const y = 25;
        const ripple = document.createElement('span');
        // make the style of the ripple with the overflow hidden
        ripple.classList.add('ripple-effect');
        ripple.style.left = `${x}px`;
        ripple.style.top = `${y}px`;
        button.appendChild(ripple);
        setTimeout(() => {
          ripple.remove();
        }, 600);
      };
    });
  }, [expanded]);

  return (
    <>
      <SlideDown className="my-dropdown-slidedown">
        {expanded ? (
          <div className="margin-top">
            <section
              className="colourShowing"
              onClick={() => {
                setExpanded(false);
              }}
              style={{
                backgroundColor: theme.background['clothing-main'],
                color: theme.text['white'],
                border:
                  theme.hair['dropDownBorder'] +
                  ' ' +
                  theme.hair['dropDownBorderColour'],
                borderBottom: 'none',
              }}
            >
              <h5>{props.headingName}</h5>
              <svg
                viewBox="0 0 24 24"
                fill="currentColor"
                height="1em"
                width="1em"
              >
                <path d="M6.293 13.293l1.414 1.414L12 10.414l4.293 4.293 1.414-1.414L12 7.586z" />
              </svg>
            </section>
            <section
              className="colourShowing2"
              style={{
                backgroundColor: theme.background['clothing-main'],
                color: theme.text['white'],
                border:
                  theme.hair['dropDownBorder'] +
                  ' ' +
                  theme.hair['dropDownBorderColour'],
                borderTop: 'none',
              }}
            >
              {hairColours.map((colour: any) => {
                const r = colour.rgb[0];
                const g = colour.rgb[1];
                const b = colour.rgb[2];
                const backgroundColour = `rgb(${r}, ${g}, ${b})`;
                return (
                  <div
                    key={colour.id}
                    className="colourBox ripple-animation-tickbox"
                    style={{
                      backgroundColor: backgroundColour,
                      border:
                        colourID === colour.id
                          ? theme.borders['border-thin'] +
                            ' ' +
                            theme.text['white']
                          : theme.borders['border-thin'] +
                            ' ' +
                            theme.hair['hairTileBorderColour'],
                    }}
                    id={colour.id}
                    onClick={() => {
                      // setCurrentClicked(colour.id);
                      props.onClickFunc(props.nameOfState, colour.id, 'colour');
                    }}
                  >
                    {colourID === colour.id ? (
                      <svg
                        fill="none"
                        viewBox="0 0 15 15"
                        height="1em"
                        width="1em"
                      >
                        <path stroke="currentColor" d="M4 7.5L7 10l4-5" />
                      </svg>
                    ) : (
                      <></>
                    )}
                  </div>
                );
              })}
            </section>
          </div>
        ) : (
          <section
            className="colourPicker"
            onClick={() => {
              setExpanded(true);
            }}
            style={{
              backgroundColor: theme.background['clothing-main'],
              color: theme.text['white'],
              border:
                theme.hair['dropDownBorder'] +
                ' ' +
                theme.hair['dropDownBorderColour'],
              borderRadius: theme.borders['border-radius'],
            }}
          >
            <h5>{props.headingName}</h5>
            <svg
              viewBox="0 0 24 24"
              fill="currentColor"
              height="1em"
              width="1em"
            >
              <path d="M16.293 9.293L12 13.586 7.707 9.293l-1.414 1.414L12 16.414l5.707-5.707z" />
            </svg>
          </section>
        )}
      </SlideDown>
    </>
  );
};

export default ColourPicker;
