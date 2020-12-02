const request = require('request');
const { encryptWithSHA256, encryptWithAES256 } = require('@utils/crypto');

const ACCESSKEY = process.env.EMAILACCESSKEY;
const SECRETKEY = process.env.EMAILSECRETKEY;

const emailController = {
  SignUpAuthentication(address, name, idx) {
    const time = Date.now();
    const result = encryptWithAES256({ Text: `${address} ${time + 7200000} ${idx}` });
    const resultURL = `https://dadaikseon.com/confirm-email?user=${encodeURIComponent(result)}`;
    const parameters = {
      userName: name,
      URL: resultURL,
    };

    const option = makeOption(2324, address, name, parameters);

    try {
      request.post(option, (err, httpResponse, body) => {});
    } catch (e) {
      /**
       * @TODO 에러 처리
       */
    }
  },

  sendId(address, name, id) {
    console.log('?????????????');
    const parameters = {
      userName: name,
      userId: id,
    };
    const option = makeOption(2368, address, name, parameters);

    try {
      request.post(option, (err, httpResponse, body) => {});
    } catch (e) {
      console.log(e);
      /**
       * @TODO 에러 처리
       */
    }
  },
};

const makeOption = (templateSid, address, name, parameters) => {
  const time = Date.now();
  const payload = `POST /api/v1/mails\n${time}\n${ACCESSKEY}`;
  const option = {
    uri: process.env.EMAILURL,
    method: 'POST',
    headers: {
      'x-ncp-apigw-timestamp': time,
      'x-ncp-iam-access-key': ACCESSKEY,
      'x-ncp-apigw-signature-v2': encryptWithSHA256(SECRETKEY, payload),
    },
    body: {
      templateSid,
      individual: true,
      advertising: false,
      recipients: [
        {
          address,
          name,
          type: 'R',
          parameters,
        },
      ],
    },
    json: true,
  };
  return option;
};

module.exports = { emailController };
