const dev = process.env.NODE_ENV !== 'production';

const swaggerDefinition = {
  info: {
    // API informations (required)
    title: 'TOTP App', // Title (required)
    version: '1.0.0', // Version (required)
    description: 'TOTP App API', // Description (optional)
  },
  host: dev ? 'localhost:3000' : 'dadaikseon.com', // Host (optional)
  schemes: dev ? ['http'] : ['https'],
  basePath: '/api', // Base path (optional)
  servers: ['http://localhost:3000'],
  securityDefinitions: {
    jwt: {
      type: 'apiKey',
      name: 'Authorization',
      in: 'header',
    },
  },
  components: {},
};

module.exports = swaggerDefinition;
