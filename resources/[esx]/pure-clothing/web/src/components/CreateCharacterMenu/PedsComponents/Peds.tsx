import React, { useEffect, useMemo, useState } from 'react';
import allPeds from '../../../../../peds/peds.json';
import DefaultPed from './AllComponents/DefaultPed';
import CustomPed from './AllComponents/CustomPed';
import { useAppDistpatch, useAppSelector } from '../../../store/store';
import { setCurrentPed } from '../../../store/features/createChar/pedsSlice';
import 'react-slidedown/lib/slidedown.css';
import '../../Component.scss';

const Peds: React.FC = () => {
  const arr: string[] = [];
  const [filteredFemale, setFilteredFemale] = useState(arr);
  const [filteredMale, setFilteredMale] = useState(arr);
  const [filteredGangMale, setFilteredGangMale] = useState(arr);
  const [filteredGangFemale, setFilteredGangFemale] = useState(arr);
  const [filteredAnimal, setFilteredAnimal] = useState(arr);
  const [currentClicked, setCurrentClicked] = useState('');
  const dispatch = useAppDistpatch();
  const currentPed = useAppSelector((state: any) => state.peds.currentPed);
  const config = useAppSelector((state) => state.config.config);
  const language = useAppSelector((state) => state.config.language);

  useMemo(() => {
    setFilteredFemale(allPeds[0].female);
    setFilteredMale(allPeds[0].male);
    setFilteredGangMale(allPeds[0].gang_male);
    setFilteredGangFemale(allPeds[0].gang_female);
    setFilteredAnimal(allPeds[0].animals);
    setCurrentClicked(currentPed);
  }, []);

  useEffect(() => {
    setCurrentClicked(currentPed);
  }, [currentPed]);

  const clickEvent = (clicked: string) => {
    setCurrentClicked(clicked);
    dispatch(setCurrentPed(clicked));
  };

  return (
    <>
      {config.nui['sections']['peds'].malePeds && (
        <DefaultPed
          title={language.menus.peds.malePeds}
          JSONtable={filteredMale}
          id="male"
          currentClicked={currentClicked}
          setCurrentClicked={clickEvent}
        />
      )}
      {config.nui['sections']['peds'].femalePeds && (
        <DefaultPed
          title={language.menus.peds.femalePeds}
          JSONtable={filteredFemale}
          id="female"
          currentClicked={currentClicked}
          setCurrentClicked={clickEvent}
        />
      )}
      {config.nui['sections']['peds'].gangMalePeds && (
        <DefaultPed
          title={language.menus.peds.gangMalePeds}
          JSONtable={filteredGangMale}
          id="gangMale"
          currentClicked={currentClicked}
          setCurrentClicked={clickEvent}
        />
      )}
      {config.nui['sections']['peds'].gangFemalePeds && (
        <DefaultPed
          title={language.menus.peds.gangFemalePeds}
          JSONtable={filteredGangFemale}
          id="gangFemale"
          currentClicked={currentClicked}
          setCurrentClicked={clickEvent}
        />
      )}
      {config.nui['sections']['peds'].animalPeds && (
        <DefaultPed
          title={language.menus.peds.animalPeds}
          JSONtable={filteredAnimal}
          id="animals"
          currentClicked={currentClicked}
          setCurrentClicked={clickEvent}
        />
      )}
      {config.nui['sections']['peds'].customPeds && (
        <CustomPed setCurrentClicked={clickEvent} />
      )}
    </>
  );
};

export default Peds;
