module.exports = {
  theme: {
    themeVariants: ['dark'],
    extend: {},
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'dark', 'dark:hover', 'dark:focus'],
    textColor: ['responsive', 'hover', 'focus', 'dark', 'dark:hover', 'dark:focus'],
  },
  plugins: [
    require('tailwindcss-multi-theme'),
    // require('@tailwindcss/forms'),
    require('@tailwindcss/custom-forms')
  ],
}
