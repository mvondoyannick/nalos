const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  theme: {
    extend: {
      colors: {
        'light-blue': colors.lightBlue,
        teal: colors.teal,
        rose: colors.rose,
      }
    },
  },
  variants: {},
  plugins: [
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/forms'),
  ],
}
