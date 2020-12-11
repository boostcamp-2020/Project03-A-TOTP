require('dotenv').config();
const redis = require('redis');
const logService = require('@/services/web/log');

const redisOption = {
  host: process.env.DBHOST,
};
const redisModel = {
  notifyEvent() {
    const rid = redis.createClient(redisOption);
    const subscriber = redis.createClient(redisOption);

    rid.config('SET', 'notify-keyspace-events', 'KEA');
    const EVENT_EXPIRED = '__keyevent@0__:expired';
    const EVENT_DEL = '__keyevent@0__:del';

    subscriber.on('pmessage', async function (pattern, channel, message) {
      if (channel === EVENT_EXPIRED || channel === EVENT_DEL) {
        message = message.replace('session:', '');
        await logService.update({ sid: message, isLoggedOut: true });
      }
    });

    subscriber.psubscribe('__key*__:*');
    rid.setex('string key', 10, 'string val', redis.print);
  },

  client() {
    const client = redis.createClient(redisOption);

    client.on('error', (error) => {
      console.log(error);
    });

    return client;
  },
};

// session 작업 이후에 고려
module.exports = redisModel;
