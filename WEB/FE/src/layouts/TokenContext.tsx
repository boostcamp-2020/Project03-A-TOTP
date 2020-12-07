import React, { useState, createContext } from 'react';

interface TokenProviderProps {
  children: React.ReactNode;
}

interface SetTokenContextProps {}

export const TokenContext = createContext<string>('');
export const SetTokenContext = createContext({} as React.Dispatch<React.SetStateAction<string>>);

const TokenProvider = ({ children }: TokenProviderProps): JSX.Element => {
  const [csrfToken, setcsrfToken] = useState('');

  return (
    <TokenContext.Provider value={csrfToken}>
      <SetTokenContext.Provider value={setcsrfToken}>{children}</SetTokenContext.Provider>
    </TokenContext.Provider>
  );
};

export default TokenProvider;
