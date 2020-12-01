require('dotenv').config();
const redis = require('redis');

const client = () => {
  const redisOption = {
    host: process.env.DBHOST,
  };

  const client = redis.createClient(redisOption);
  client.on('error', (error) => {
    console.log(error);
  });

  return client;
};

// session 작업 이후에 고려
module.exports = client;
