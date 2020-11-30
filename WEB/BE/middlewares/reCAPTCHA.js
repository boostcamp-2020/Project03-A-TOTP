const axios = require('axios');
const createError = require('http-errors');

const reCAPTCHA = {
  async verify(req, res, next) {
    const { reCaptchaToken } = req.body;

    if (!reCaptchaToken) {
      return next(createError(400, 'reCaptcha token is missing'));
    }

    const result = await axios.post(
      `https://www.google.com/recaptcha/api/siteverify?secret=${process.env.RECAPTCHAKEY}&response=${reCaptchaToken}`
    );

    if (result.data.success === true && result.data.score > 0.3) next();
    else next(createError(401, 'You are a Bot'));
  },
};

module.exports = reCAPTCHA;
