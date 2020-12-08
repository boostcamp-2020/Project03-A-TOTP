require('dotenv').config();
const redis = require('redis');
const logService = require('@services/log');

const client = () => {
  const redisOption = {
    host: process.env.DBHOST,
  };

  const client = redis.createClient(redisOption);
  const rid = redis.createClient(redisOption);
  rid.config('SET', 'notify-keyspace-events', 'Ex');

  const subscriber = redis.createClient(redisOption);
  client.on('error', (error) => {
    console.log(error);
  });

  subscriber.on('pmessage', async function (pattern, channel, message) {
    await logService.update({ sid: message, isLoggedOut: true });
  });
  subscriber.psubscribe('__key*__:*');
  rid.setex('string key', 10, 'string val', redis.print);
  return client;
};

// session 작업 이후에 고려
module.exports = client;
