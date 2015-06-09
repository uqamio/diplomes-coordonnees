util = require('util');

module.exports = {
  scripts: {
    options: {
      transform: (filePath) ->
        filePath = filePath.replace('/dist/public/', '');
        return util.format('<script src="%s"></script>', filePath);
    },
    files: {
      '<%= repertoires.distribution %>public/index.html': [
        '<%= repertoires.distribution %>public/scripts/app.js',
        '<%= repertoires.distribution %>public/scripts/app.config.js',
        '<%= repertoires.distribution %>public/scripts/**/*.js'
      ]
    }
  },
  css: {
    options: {
      transform: (filePath) ->
        filePath = filePath.replace('/dist/public/', '');
        return util.format('<link rel="stylesheet" href="%s">', filePath);
    },
    files: {
      '<%= repertoires.distribution %>public/index.html': [
        '<%= repertoires.distribution %>public/css/**/*.css'
      ]
    }
  }
}