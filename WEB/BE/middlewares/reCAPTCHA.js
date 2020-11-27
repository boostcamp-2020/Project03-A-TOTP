const axios = require('axios');

const reCAPTCHA = {
  async verify(req, res, next) {
    const { token } = req.body;
    const result = await axios.post(
      `https://www.google.com/recaptcha/api/siteverify?secret=${process.env.RECAPTCHAKEY}&response=${token}`
    );
    if (result.data.success === true && result.data.score > 0.3) next();
    else next(new Error('You are a Bot'));
  },
};

module.exports = reCAPTCHA;
