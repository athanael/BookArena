const { environment } = require('@rails/webpacker')

environment.config.merge({
  entry: {
    application: './app/javascript/controllers/application.js',
  },
});

module.exports = environment;
