const request = require('request');
const { encryptWithSHA256, decryptWithAES256, encryptWithAES256 } = require('@utils/crypto');

const ACCESSKEY = process.env.EMAILACCESSKEY;
const SECRETKEY = process.env.EMAILSECRETKEY;
const time = Date.now();
const payload = `POST /api/v1/mails\n${time}\n${ACCESSKEY}`;

const requestEmail = (address, name, idx) => {
  const result = encryptWithAES256({ Text: `${address} ${time + 7200000} ${idx}` });
  const resultURL = `https://dadaikseon.com/confirm-email?user=${encodeURIComponent(result)}`;
  console.log(resultURL);
  const option = {
    uri: process.env.EMAILURL,
    method: 'POST',
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
    request.post(option, (err, httpResponse, body) => {});
  } catch (e) {
    console.log(e);
  }
};

module.exports = { requestEmail };
