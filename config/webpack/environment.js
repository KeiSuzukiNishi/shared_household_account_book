const { environment } = require('@rails/webpacker');

const tailwindcss = require('tailwindcss');
environment.loaders.get('sass').use.push({
  loader: 'postcss-loader',
  options: {
    postcssOptions: {
      plugins: [
        tailwindcss('./path/to/your/tailwind.config.js'),
        require('autoprefixer'),
      ],
    },
  },
});

module.exports = environment;
