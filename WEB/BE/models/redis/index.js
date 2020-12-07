require('dotenv').config();
const redis = require('redis');

const client = () => {
  const redisOption = {
    host: process.env.DBHOST,
  };

  const client = redis.createClient(redisOption);
  client.config('SET', 'notify-keyspace-events', 'Ex');

  const subscriber = redis.createClient(redisOption);
  client.on('error', (error) => {
    console.log(error);
  });

  subscriber.on('pmessage', function (pattern, channel, message) {
    /** @TODO log 변경 */
    console.log(`pattern : ${pattern} channel: ${channel} message : ${message}`);
  });
  subscriber.psubscribe('__key*__:*');
  client.setex('string key', 10, 'string val', redis.print);
  return client;
};

// session 작업 이후에 고려
module.exports = client;
