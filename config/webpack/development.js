process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.entry.set('application', './app/javascript/application.js')

module.exports = environment.toWebpackConfig()
