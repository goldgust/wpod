const path = require('path');

module.exports = {
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    disableHostCheck: true,
    host: '0.0.0.0',
    compress: true,
    port: 8080
  }
};