module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*",
    "./client/src/**/*.{html,ts}",
  ],
  theme: {
    extend: {
      fontFamily: {
        headings: ["Lexend Deca"],
        body: ["Source Sans Pro"],
      },
    },
  },
  plugins: [],
};
