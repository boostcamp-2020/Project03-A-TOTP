module.exports = (api) => {
  api.cache(true);

  const presets = [
    [
      '@babel/preset-env',
      {
        targets: '> 0.25%, not dead',
        useBuiltIns: 'usage',
        corejs: 3,
        shippedProposals: true,
        modules: false,
      },
    ],
    '@babel/preset-typescript',
    '@babel/preset-react',
  ];

  const plugins = ['@babel/plugin-proposal-optional-chaining'];

  return {
    presets,
    plugins,
  };
};
