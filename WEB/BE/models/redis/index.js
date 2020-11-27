const dotenv = require('dotenv').config();
const redis = require('redis');

const redisOption = {
  host: process.env.DBHOST,
};

const client = redis.createClient(redisOption);

client.on('error', (error) => {
  console.log(error);
});

// client.get('test', function (err, reply) {
//   console.log(reply);
// });

// session 작업 이후에 고려
