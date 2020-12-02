import React from 'react';
import { Modal } from '@components/common/Modal';
import { text } from '@storybook/addon-knobs';

export default {
  title: 'components/Modal',
  component: Modal,
};

export const modal = () => (
  <div>
    <Modal>{text('내용', 'Im Modal!')}</Modal>
  </div>
);
