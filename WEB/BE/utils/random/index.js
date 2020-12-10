const makeRandom = (num = 6, length = undefined) => {
  return Array.from(Array(num).keys()).reduce(
    (prev, now) =>
      (prev += Math.random()
        .toString(36)
        .substr(2, length ? length + 2 : undefined)),
    ''
  );
};

module.exports = { makeRandom };
