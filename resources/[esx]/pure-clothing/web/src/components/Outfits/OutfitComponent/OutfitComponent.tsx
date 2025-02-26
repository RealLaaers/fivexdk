import React, { useState, useEffect } from 'react';
import { useAppSelector } from '../../../store/store';
import '../Outfit.scss';
import { sendNui } from '../../../utils/sendNui';

interface Props {
  name: string;
  id: number;
  isDisabled: boolean;
  uniqueOutfitid: string;
  useOutfit: (uniqueOutfitid: string) => void;
  currentClicked: (uniqueOutfitid: string) => void;
  deleteOutfit: (uniqueOutfitid: string) => void;
  setDeleteOutfit: React.Dispatch<React.SetStateAction<boolean>>;
}

const OutfitComponent: React.FC<Props> = (props) => {
  const theme = useAppSelector((state) => state.theme.theme);
  const [currentName, setCurrentName] = useState<string>('');
  const language = useAppSelector((state) => state.config.language);

  useEffect(() => {
    setCurrentName(props.name);
  }, []);
  return (
    <>
      <section
        className="outfitComponent"
        style={{
          backgroundColor: theme.background['clothing-main'],
          border:
            theme.borders['border-thin'] +
            ' ' +
            theme.background['clothing-top-block'],
        }}
      >
        <section className="left">
          {props.isDisabled ? (
            <h1
              style={{
                color: theme.text['white'],
              }}
            >
              {props.name}
            </h1>
          ) : (
            <input
              className="outfitNameInput"
              type="text"
              value={currentName}
              style={{
                color: theme.text['white'],
              }}
              onChange={(e) => {
                setCurrentName(e.target.value);
              }}
              onKeyPress={(e) => {
                if (e.key === 'Enter') {
                  // console.log('lolerz', currentName);
                  sendNui('updateOutfitName', {
                    uniqueOutfitid: props.uniqueOutfitid,
                    name: currentName,
                  });
                }
              }}
            ></input>
            // <h1
            //   style={{
            //     color: theme.text['white'],
            //   }}
            // >
            //   {props.name}
            // </h1>
          )}
          <h2
            style={{
              color: theme.text['text-like-borders'],
            }}
          >
            {language.popouts.outfit} {props.id}
          </h2>
        </section>
        <section
          className="right"
          style={{
            backgroundColor: theme.background['clothing-top-block'],
            color: theme.text['white'],
          }}
        >
          <span id={props.uniqueOutfitid + 'use'} className="displayAbove">
            <p>{language.newUpdate.use}</p>
          </span>
          <svg
            fill="none"
            viewBox="0 0 24 24"
            height="2em"
            width="2em"
            className="notDisabled"
            onClick={() => {
              props.useOutfit(props.uniqueOutfitid);
            }}
            onMouseEnter={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'use'
              );
              if (span) {
                span.style.visibility = 'visible';
                span.style.marginLeft = '-7.65em';
              }
            }}
            onMouseLeave={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'use'
              );
              if (span) {
                span.style.visibility = 'hidden';
              }
            }}
          >
            <path
              fill="currentColor"
              d="M11 5a1 1 0 112 0v7.158l3.243-3.243 1.414 1.414L12 15.986 6.343 10.33l1.414-1.414L11 12.158V5z"
            />
            <path
              fill="currentColor"
              d="M4 14h2v4h12v-4h2v4a2 2 0 01-2 2H6a2 2 0 01-2-2v-4z"
            />
          </svg>
          <span id={props.uniqueOutfitid + 'share'} className="displayAbove">
            <p>{language.newUpdate.share}</p>
          </span>
          <svg
            viewBox="0 0 576 512"
            fill="currentColor"
            height="1.5em"
            width="1.5em"
            className={props.isDisabled ? 'disabled' : 'notDisabled'}
            onClick={() => {
              props.currentClicked(props.uniqueOutfitid);
            }}
            onMouseEnter={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'share'
              );
              if (span) {
                span.style.visibility = 'visible';
              }
            }}
            onMouseLeave={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'share'
              );
              if (span) {
                span.style.visibility = 'hidden';
              }
            }}
          >
            <path d="M384 24c0-9.6 5.7-18.2 14.5-22s19-2 26 4.6l144 136c4.8 4.5 7.5 10.8 7.5 17.4s-2.7 12.9-7.5 17.4l-144 136c-7 6.6-17.2 8.4-26 4.6S384 305.5 384 296v-72h-46.5c-45 0-81.5 36.5-81.5 81.5 0 22.3 10.3 34.3 19.2 40.5 6.8 4.7 12.8 12 12.8 20.3 0 9.8-8 17.8-17.8 17.8h-2.5c-2.4 0-4.8-.4-7.1-1.4C242.8 374.8 160 333.4 160 240c0-79.5 64.5-144 144-144h80V24zM0 144c0-44.2 35.8-80 80-80h16c17.7 0 32 14.3 32 32s-14.3 32-32 32H80c-8.8 0-16 7.2-16 16v288c0 8.8 7.2 16 16 16h288c8.8 0 16-7.2 16-16v-16c0-17.7 14.3-32 32-32s32 14.3 32 32v16c0 44.2-35.8 80-80 80H80c-44.2 0-80-35.8-80-80V144z" />
          </svg>
          <span id={props.uniqueOutfitid + 'delete'} className="displayAbove">
            <p>{language.newUpdate.delete}</p>
          </span>
          <svg
            viewBox="0 0 24 24"
            fill="currentColor"
            height="1.5em"
            width="1.5em"
            className={props.isDisabled ? 'disabled' : 'notDisabled'}
            onClick={() => {
              props.deleteOutfit(props.uniqueOutfitid);
              props.setDeleteOutfit(true);
            }}
            onMouseEnter={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'delete'
              );
              if (span) {
                span.style.visibility = 'visible';
                span.style.marginLeft = '8.65em';
              }
            }}
            onMouseLeave={() => {
              const span = document.getElementById(
                props.uniqueOutfitid + 'delete'
              );
              if (span) {
                span.style.visibility = 'hidden';
              }
            }}
          >
            <path d="M19 4h-3.5l-1-1h-5l-1 1H5v2h14M6 19a2 2 0 002 2h8a2 2 0 002-2V7H6v12z" />
          </svg>
        </section>
      </section>
    </>
  );
};

export default OutfitComponent;
