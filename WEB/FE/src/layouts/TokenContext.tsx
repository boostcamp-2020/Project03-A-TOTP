import React, { useState, createContext } from 'react';

interface TokenProviderProps {
  children: React.ReactNode;
}

interface SetTokenContextProps {}

export const TokenContext = createContext<string>('');
export const SetTokenContext = createContext({} as React.Dispatch<React.SetStateAction<string>>);

const TokenProvider = ({ children }: TokenProviderProps): JSX.Element => {
  const [CSRFTOKEN, setCSRFTOKEN] = useState('');

  return (
    <TokenContext.Provider value={CSRFTOKEN}>
      <SetTokenContext.Provider value={setCSRFTOKEN}>{children}</SetTokenContext.Provider>
    </TokenContext.Provider>
  );
};

export default TokenProvider;
