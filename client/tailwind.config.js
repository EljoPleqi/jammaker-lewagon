module.exports = {
  content: ["./src/**/*.{html,ts}"],
  theme: {
    extend: {
      fontFamily: {
        headings: ['"Lexend Deca"'],
        body: ['"Source Sans Pro"'],
      },
      gridTemplateColumns: {
        cookbook: "0.5fr 2fr",
        recipes: "repeat(2, 1fr)",
      },
      gridTemplateRows: {
        cookbook: "repeat(3, 1fr);",
      },
    },
  },
  plugins: [],
};
