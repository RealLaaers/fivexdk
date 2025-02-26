import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { sendNui } from '../../../utils/sendNui';

export interface ParentState {
  motherValue: number;
  motherMaxValue: number;
  fatherValue: number;
  fatherMaxValue: number;
  similarity: number;
  skinColour: number;
  gender: string;
}

const initialState: ParentState = {
  motherValue: 0,
  motherMaxValue: 23,
  fatherValue: 0,
  fatherMaxValue: 25,
  similarity: 50,
  skinColour: 50,
  gender: 'male',
};

export const parentsSlice = createSlice({
  name: 'parents',
  initialState,
  reducers: {
    setMotherValue: (state, action: PayloadAction<number>) => {
      // console.log(state.motherValue, action.payload);
      if (action.payload == 0) {
        state.motherValue = 0;
        return;
      }
      if (action.payload > 0) {
        if (state.motherValue + action.payload < state.motherMaxValue) {
          state.motherValue += action.payload;
        } else {
          state.motherValue = state.motherMaxValue;
        }
      } else {
        if (state.motherValue + action.payload > 0) {
          state.motherValue += action.payload;
        } else {
          state.motherValue = 0;
        }
      }
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setMotherValueByInput: (state, action: PayloadAction<number>) => {
      if (action.payload > 0) {
        if (action.payload < state.motherMaxValue) {
          state.motherValue = action.payload;
        } else {
          state.motherValue = state.motherMaxValue;
        }
      } else {
        if (action.payload > 0) {
          state.motherValue = action.payload;
        } else {
          state.motherValue = 0;
        }
      }
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setFatherValue: (state, action: PayloadAction<number>) => {
      if (action.payload == 0) {
        state.fatherValue = 0;
        return;
      }
      if (action.payload > 0) {
        if (state.fatherValue + action.payload < state.fatherMaxValue) {
          state.fatherValue += action.payload;
        } else {
          state.fatherValue = state.fatherMaxValue;
        }
      } else {
        if (state.fatherValue + action.payload > 0) {
          state.fatherValue += action.payload;
        } else {
          state.fatherValue = 0;
        }
      }
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setFatherValueByInput: (state, action: PayloadAction<number>) => {
      if (action.payload > 0) {
        if (action.payload < state.fatherMaxValue) {
          state.fatherValue = action.payload;
        } else {
          state.fatherValue = state.fatherMaxValue;
        }
      } else {
        if (action.payload > 0) {
          state.fatherValue = action.payload;
        } else {
          state.fatherValue = 0;
        }
      }
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setMotherMaxValue: (state, action: PayloadAction<number>) => {
      state.motherMaxValue = action.payload;
    },
    setFatherMaxValue: (state, action: PayloadAction<number>) => {
      state.fatherMaxValue = action.payload;
    },
    setSimilarity: (state, action: PayloadAction<number>) => {
      state.similarity = action.payload;
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setSkinColour: (state, action: PayloadAction<number>) => {
      state.skinColour = action.payload;
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
    setGender: (state, action: PayloadAction<string>) => {
      state.gender = action.payload;
    },
    setDefaultValues: (state) => {
      state.motherValue = 0;
      state.fatherValue = 0;
      state.similarity = 50;
      state.skinColour = 50;
      sendNui('setAppearance', {
        name: 'parents',
        mother: state.motherValue,
        father: state.fatherValue,
        mix: state.similarity,
        skinColour: state.skinColour,
      });
    },
  },
});

export default parentsSlice.reducer;
export const {
  setMotherValue,
  setMotherValueByInput,
  setFatherValue,
  setFatherValueByInput,
  setMotherMaxValue,
  setFatherMaxValue,
  setSimilarity,
  setSkinColour,
  setGender,
  setDefaultValues,
} = parentsSlice.actions;
