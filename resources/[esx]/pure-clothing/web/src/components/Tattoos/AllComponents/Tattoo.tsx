import React, { useState, useEffect } from 'react';
import { useAppSelector } from '../../../store/store';
import { SlideDown } from 'react-slidedown';
import 'react-slidedown/lib/slidedown.css';
import '../../Component.scss';

interface TattooComponentProps {
  headingName: string;
  nameOfState: string;
  handleClickFunc: (array: any) => void;
  id: string;
}

const Tattoo: React.FC<TattooComponentProps> = (props) => {
  const [search, setSearch] = useState('');
  const [visible, setVisible] = useState(false);
  const [filtered, setFiltered] = useState([]);

  const stateName: string = props.nameOfState;
  const states = useAppSelector((state: any) => state[stateName]);
  const tattooArray = states.tattoosArray;
  const currentTattoos = states.selectedTattoos;
  const clonedTattoos = JSON.parse(JSON.stringify(currentTattoos));
  const theme = useAppSelector((state) => state.theme.theme);
  const config = useAppSelector((state) => state.config.config);
  if (!config.nui['sections']['tattoos'][stateName]) {
    return null;
  }

  const langauge = useAppSelector((state) => state.config.language);

  useEffect(() => {
    setFiltered(tattooArray);
  }, []);

  useEffect(() => {
    setFiltered(tattooArray);
    // console.log('filtered', filtered);
  }, [visible, search]);

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
          <h1>
            {props.headingName} {langauge.menus.tattoos}
          </h1>
          {/* <p>{svgElement}</p> */}
        </div>
        <div
          className="dropdownDivider fixed-dropdown-height"
          style={{
            color: theme.text['white'],
          }}
        >
          <h2>
            {states.amountOfTattoos} {langauge.general.models}
          </h2>
          <div>
            <div
              onClick={() => {
                setVisible(!visible);
                // setVisible(true);
                const element = document.getElementById(props.id);
                if (element) {
                  if (!visible) {
                    element.classList.remove('notChecked');
                    element.classList.add('checked');
                  }
                  if (visible) {
                    element.classList.remove('checked');
                    element.classList.add('notChecked');
                  }
                }
              }}
              className="dropDownBar notChecked"
              id={props.id}
              style={{
                color: theme.text['white'],
                backgroundColor: theme.background['clothing-main'],
                borderBottom:
                  theme.borders['border-thin'] +
                  ' ' +
                  (visible
                    ? theme.mainColourway['main-colour']
                    : theme.dropdownDivider['border-colour']),
              }}
            >
              <input
                type="text"
                placeholder={props.headingName}
                className="inputText"
                onChange={(e) => {
                  setSearch(e.target.value.toLowerCase());
                }}
                style={{
                  color: theme.text['white'],
                }}
              />
              <svg
                viewBox="0 0 24 24"
                fill="currentColor"
                height="1em"
                width="1em"
              >
                <path d="M16.293 9.293L12 13.586 7.707 9.293l-1.414 1.414L12 16.414l5.707-5.707z" />
              </svg>
            </div>
            <SlideDown>
              {visible ? (
                <div
                  className="slide-down"
                  style={{
                    backgroundColor: theme.background['clothing-main'],
                  }}
                >
                  <ul>
                    {filtered
                      .filter((item: any) => {
                        // console.log(JSON.stringify(item), item.Name);
                        return search === ''
                          ? item.LocalizedName.toLowerCase()
                          : item.LocalizedName.toLowerCase().includes(search);
                      })
                      .map((item: any, index: number) => {
                        let isAlreadyInArray = false;
                        for (let i = 0; i < currentTattoos.length; i++) {
                          const element = currentTattoos[i];
                          if (element.name === item.Name) {
                            isAlreadyInArray = true;
                          }
                        }
                        return (
                          <li
                            key={index}
                            className="checkBoxHousing"
                            onClick={(e: any) => {
                              const element = document.getElementById(
                                item.Name
                              ) as HTMLInputElement;
                              if (element) {
                                let isChecked = element.checked;
                                const objectToPush = {
                                  name: item.Name,
                                  hashNameMale: item.HashNameMale,
                                  hashNameFemale: item.HashNameFemale,
                                  localizedName: item.LocalizedName,
                                };
                                if (e.target.className) {
                                  isChecked = !isChecked;
                                }
                                if (!isChecked) {
                                  clonedTattoos.push(objectToPush);
                                  element.checked = true;
                                } else {
                                  const index = clonedTattoos.findIndex(
                                    (item: any) => {
                                      return item.name === element.value;
                                    }
                                  );
                                  if (index > -1) {
                                    clonedTattoos.splice(index, 1);
                                  }
                                  element.checked = false;
                                }
                                props.handleClickFunc(clonedTattoos);
                                return;
                              }
                            }}
                          >
                            <input
                              defaultChecked={isAlreadyInArray}
                              type="checkbox"
                              id={item.Name}
                              name="checkbox"
                              value={item.Name}
                              className="checkboxers"
                              style={{
                                color: theme.text['main'],
                                border:
                                  theme.borders['border-thin'] + ' #ffffffb3',
                              }}
                              onMouseOver={(e) => {
                                const element = document.getElementById(item);
                                if (element) {
                                  element.style.boxShadow =
                                    theme.checkbox['checkbox-hover'];
                                }
                              }}
                              onMouseOut={(e) => {
                                const element = document.getElementById(item);
                                if (element) {
                                  element.style.boxShadow = 'none';
                                }
                              }}
                            />
                            <p className="labelling" id={item.Name}>
                              <span>{item.LocalizedName}</span>
                            </p>
                          </li>
                        );
                      })}
                  </ul>
                </div>
              ) : null}
            </SlideDown>
          </div>
        </div>
      </div>
    </>
  );
};

export default Tattoo;
