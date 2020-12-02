const path = require('path');

module.exports = {
  stories: ['../src/stories/**/*.stories.mdx', '../src/stories/**/*.stories.@(js|jsx|ts|tsx)'],
  addons: ['@storybook/addon-links', '@storybook/addon-essentials', '@storybook/addon-knobs'],
  webpackFinal: async (config) => {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@': path.resolve(__dirname, '../src/'),
      '@api': path.resolve(__dirname, '../src/api/'),
      '@hooks': path.resolve(__dirname, '../src/hooks/'),
      '@components': path.resolve(__dirname, '../src/components/'),
      '@styles': path.resolve(__dirname, '../src/styles'),
      '@static': path.resolve(__dirname, '../static'),
      '@utils': path.resolve(__dirname, '../src/utils/'),
      '@types': path.resolve(__dirname, '../src/types/'),
      '@layouts': path.resolve(__dirname, '../src/layouts/'),
      '@pages': path.resolve(__dirname, '../src/pages/'),
    };
    config.resolve.extensions.push('.js', '.jsx', '.ts', '.tsx');
    return config;
  },
  typescript: {
    check: false,
    checkOptions: {},
    reactDocgen: 'react-docgen-typescript',
    reactDocgenTypescriptOptions: {
      shouldExtractLiteralValuesFromEnum: true,
      propFilter: (prop) => (prop.parent ? !/node_modules/.test(prop.parent.fileName) : true),
    },
  },
};
