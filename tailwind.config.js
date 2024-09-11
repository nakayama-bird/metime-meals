module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/decorators/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend:{
      fontFamily: {
      'zen': ['Zen Kaku Gothic New', 'sans-serif'],
      'lilita': ['Lilita One', 'system-ui'],
    },
  },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["cupcake"],
  },
}
