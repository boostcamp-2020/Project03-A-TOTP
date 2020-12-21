import { useState } from 'react';

export const useInput = (
  initialState: string,
): [state: string, onChange: (e: React.ChangeEvent<HTMLInputElement>) => void] => {
  const [state, setState] = useState(initialState);
  const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setState(e.target.value);
  };

  return [state, onChange];
};
