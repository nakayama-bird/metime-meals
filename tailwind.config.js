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
    themes: [
      {
        mytheme: {
          
        "primary": "#326432",
                  
        "secondary": "#e2ab3a",
                  
        "accent": "#e78728",
                  
        "neutral": "#e78728",
                  
        "base-100": "#ffffff",

        "base-200": "#f7ede2",
                  
        "info": "#00B5FF",
                  
        "success": "#00A96E",
                  
        "warning": "#FFBE00",
                  
        "error": "#FF5761",
                  },
                },
              ],
          },
}
