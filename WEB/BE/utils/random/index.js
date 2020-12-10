const makeRandom = () => {
  return Array.from(Array(6).keys()).reduce(
    (prev, now) => (prev += Math.random().toString(36).substr(2)),
    ''
  );
};

module.exports = { makeRandom };
