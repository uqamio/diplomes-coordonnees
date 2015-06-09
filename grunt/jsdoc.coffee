module.exports =
{
  serveur: {
    src: ['server/**/*.js'],
    options: {
      destination: './dist/public/documentation/serveur',
      template: "node_modules/grunt-jsdoc/node_modules/ink-docstrap/template",
      configure: "node_modules/grunt-jsdoc/node_modules/ink-docstrap/template/jsdoc.conf.json"
    }
  }
};