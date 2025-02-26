import React, { useState } from 'react';
import { useAppDistpatch, useAppSelector } from '../../../../store/store';
import { togglePopup } from '../../../../store/features/popup/popupSlice';
import Radio from '@mui/material/Radio';
import FormControlLabel from '@mui/material/FormControlLabel';
import '../Popup.scss';
import { sendNui } from '../../../../utils/sendNui';
import { fetchNui } from '../../../../utils/fetchNui';

const SavePopup: React.FC = () => {
  const showPopup = useAppSelector((state) => state.togglePopup.showPopup);
  const config = useAppSelector((state) => state.config.config);
  const theme = useAppSelector((state) => state.theme.theme);
  const dispatch = useAppDistpatch();
  const [selectedValue, setSelectedValue] = useState(config.defaultPayment);
  const [currentPrice, setCurrentPrice] = useState(0);
  const currentPage = useAppSelector((state) => state.currentPage.currentPage);
  const language = useAppSelector((state) => state.config.language);

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSelectedValue(event.target.value);
  };

  fetchNui('getPrice', { type: currentPage })
    .then((data) => {
      // console.log(JSON.stringify(data));
      setCurrentPrice(data);
    })
    .catch((err) => {
      console.log(err);
    });

  return (
    <div
      className="popupContainer saveHeight"
      style={{
        backgroundColor: theme.background['clothing-main'],
        borderRadius: theme.borders['border-radius'],
        color: theme.text['white'],
        boxShadow: theme.background['box-shadow'],
      }}
    >
      <div className="spitIntoGrids saveHeight">
        <div>
          <h1>{language.popouts.savePopup.title}</h1>
        </div>
        <div className="middle" style={{ color: theme.text['grey-faded'] }}>
          <h3
            style={{
              color: theme.sidebar['save'],
            }}
          >
            {language.popouts.savePopup.price}
            {currentPrice}
          </h3>
          <h3>{language.popouts.savePopup.message}</h3>
        </div>
        <div>
          <div className="bottom">
            <FormControlLabel
              value="end"
              control={
                <Radio
                  checked={selectedValue === 'cash'}
                  onChange={handleChange}
                  value="cash"
                  name="radio-buttons"
                  inputProps={{ 'aria-label': 'A' }}
                  sx={{
                    color: theme.sidebar['save'],
                    '&.Mui-checked': {
                      color: theme.sidebar['save'],
                    },
                  }}
                />
              }
              label={language.popouts.savePopup.cash}
              labelPlacement="end"
            />
            <FormControlLabel
              value="end"
              control={
                <Radio
                  checked={selectedValue === 'bank'}
                  onChange={handleChange}
                  value="bank"
                  name="radio-buttons"
                  // inputProps={{ 'aria-label': 'B' }}
                  sx={{
                    color: theme.sidebar['save'],
                    '&.Mui-checked': {
                      color: theme.sidebar['save'],
                    },
                  }}
                />
              }
              label={language.popouts.savePopup.bank}
              labelPlacement="end"
            />
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                dispatch(togglePopup(!showPopup));
                sendNui('saveButton', {
                  type: 'clothing',
                  payment: config.defaultPayment,
                  currentPage: currentPage,
                });
              }}
              style={{
                backgroundColor: theme.sidebar['save'],
                color: theme.text['white'],
              }}
            >
              {language.general.save}
            </div>
            <div
              className="ripple-animation button cancel"
              onClick={() => {
                dispatch(togglePopup(!showPopup));
              }}
              style={{
                backgroundColor: theme.sidebar['delete'],
                color: theme.text['white'],
              }}
            >
              {language.general.close}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SavePopup;
