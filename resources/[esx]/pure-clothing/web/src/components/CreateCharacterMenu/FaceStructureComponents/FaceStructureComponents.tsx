import React from 'react';
import Parents from './AllComponents/Parents';
import Nose from './AllComponents/Nose';
import Neck from './AllComponents/Neck';
import Chin from './AllComponents/Chin';
import Jaw from './AllComponents/Jaw';
import Lip from './AllComponents/Lip';
import Eyes from './AllComponents/Eyes';
import Eyebrow from './AllComponents/Eyebrow';
import Cheek from './AllComponents/Cheek';

const FaceStructureComponents: React.FC = () => {
  return (
    <>
      <Parents />
      <Nose />
      <Eyebrow />
      <Cheek />
      <Eyes />
      <Lip />
      <Jaw />
      <Chin />
      <Neck />
    </>
  );
};

export default FaceStructureComponents;
