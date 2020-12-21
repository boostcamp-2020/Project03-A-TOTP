import React from 'react';
import { MemoryRouter } from 'react-router-dom';
import { TOTPModal } from '@components/TOTPModal/TOTPModal';
import { text, boolean } from '@storybook/addon-knobs';

export default {
  title: 'common/TOTPModal',
  component: TOTPModal,
};

export const totpModal = () => (
  <MemoryRouter>
    <TOTPModal isOpen={boolean('isOpen', true)} TOTP={text('TOTP', '')} />
  </MemoryRouter>
);
