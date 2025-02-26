import React, { useState, useEffect } from 'react';
import { SlideDown } from 'react-slidedown';
import { useAppSelector } from '../../../../store/store';
import 'react-slidedown/lib/slidedown.css';
import '../../../Component.scss';

interface Props {
  JSONtable: any;
  title: string;
  id: string;
  currentClicked?: string;
  setCurrentClicked: (clicked: string) => void;
}

const DefaultPed: React.FC<Props> = (props) => {
  const [search, setSearch] = useState('');
  const [visible, setVisible] = useState(false);
  const [filtered, setFiltered] = useState([]);
  const theme = useAppSelector((state) => state.theme.theme);

  useEffect(() => {
    setFiltered(props.JSONtable);
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
          <h1>{props.title}</h1>
        </div>
        <div
          className="dropdownDivider fixed-dropdown-height"
          style={{
            color: theme.text['white'],
          }}
        >
          <h2>{props.JSONtable.length} Models</h2>
          <div>
            <div
              onClick={() => {
                setVisible(!visible);
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
                placeholder={props.title}
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
                        return search === '' ? item : item.includes(search);
                      })
                      .map((item: any, index: number) => {
                        return (
                          <li
                            key={index}
                            className="checkBoxHousing"
                            onClick={() => {
                              if (props.currentClicked !== item) {
                                props.setCurrentClicked(item);
                              } else {
                                props.setCurrentClicked('');
                              }
                            }}
                          >
                            <input
                              // defaultChecked={false}
                              type="checkbox"
                              id={item}
                              name="checkbox"
                              checked={props.currentClicked === item}
                              // value={item.Name}
                              className="checkboxers"
                              onChange={() => {
                                // console.log(e.target.value, 'e.target.value');
                              }}
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
                            <p className="labelling">
                              <span>{item}</span>
                            </p>
                          </li>
                        );
                      })}
                    ;
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

export default DefaultPed;
