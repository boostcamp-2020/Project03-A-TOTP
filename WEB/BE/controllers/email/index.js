const request = require('request');
const { encryptWithSHA256, decryptWithAES256, encryptWithAES256 } = require('@utils/crypto');

const ACCESSKEY = process.env.EMAILACCESSKEY;
const SECRETKEY = process.env.EMAILSECRETKEY;
const time = Date.now();
const payload = `POST /api/v1/mails\n${time}\n${ACCESSKEY}`;

const requestEmail = (address, name) => {
  const result = encryptWithAES256({ Text: `${address} ${time + 7200000}` });
  const resultURL = `https://dadaikseon.com/confirm-email?user=${encodeURIComponent(result)}`;

  const option = {
    uri: process.env.EMAILURL,
    method: '',
    headers: {
      'x-ncp-apigw-timestamp': time,
      'x-ncp-iam-access-key': ACCESSKEY,
      'x-ncp-apigw-signature-v2': encryptWithSHA256(SECRETKEY, payload),
    },
    body: {
      templateSid: 2324,
      individual: true,
      advertising: false,
      recipients: [
        {
          address: address,
          name: name,
          type: 'R',
          parameters: {
            userName: name,
            URL: resultURL,
          },
        },
      ],
    },
    json: true,
  };
  try {
    request.post(option, (err, httpResponse, body) => {
      console.log(body);
    });
  } catch (e) {
    console.log(e);
  }
};

module.exports = { requestEmail };
