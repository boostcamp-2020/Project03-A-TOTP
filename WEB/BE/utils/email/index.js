const { encryptWithSHA256, encryptWithAES256 } = require('@utils/crypto');
const axios = require('axios');

const ACCESSKEY = process.env.EMAILACCESSKEY;
const SECRETKEY = process.env.EMAILSECRETKEY;
const COMFIRMURL = 'https://dadaikseon.com/confirm-email?user=';

const emailSender = {
  async SignUpAuthentication(address, name, idx) {
    const resultURL = makeConfirmURL(address, idx);

    const parameters = {
      userName: name,
      URL: resultURL,
    };

    const option = makeOption(2324, address, name, parameters);

    try {
      await axios(option);
    } catch (e) {
      throw new Error(e);
    }
  },

  async sendId(address, name, id) {
    const parameters = {
      userName: name,
      userId: id,
    };
    const option = makeOption(2368, address, name, parameters);

    try {
      await axios(option);
    } catch (e) {
      throw new Error(e);
    }
  },

  async sendPassword(user) {
    const url = '';
    const { email, name } = user;
    const parameters = {
      userName: name,
      URL: url,
    };

    const option = makeOption(2373, email, name, parameters);

    try {
      await axios(option);
    } catch (e) {
      throw new Error(e);
    }
  },
};

const makeOption = (templateSid, address, name, parameters) => {
  const time = Date.now();
  const payload = `POST /api/v1/mails\n${time}\n${ACCESSKEY}`;
  const option = {
    url: process.env.EMAILURL,
    method: 'POST',
    headers: {
      'x-ncp-apigw-timestamp': time,
      'x-ncp-iam-access-key': ACCESSKEY,
      'x-ncp-apigw-signature-v2': encryptWithSHA256(SECRETKEY, payload),
    },
    data: {
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
  };
  return option;
};

const makeConfirmURL = (address, idx) => {
  const time = Date.now();
  const result = encryptWithAES256({ Text: `${address} ${time + 7200000} ${idx}` });
  return `${COMFIRMURL}${encodeURIComponent(result)}`;
};

const makePassChangeURL = () => {};

module.exports = { emailSender };
