const swaggerDefinition = {
  info: {
    // API informations (required)
    title: 'TOTP App', // Title (required)
    version: '1.0.0', // Version (required)
    description: 'TOTP App API', // Description (optional)
  },
  host: 'https://dadaikseon.com', // Host (optional)
  basePath: '/api', // Base path (optional)
  servers: ['http://localhost:3000'],
};

module.exports = swaggerDefinition;
