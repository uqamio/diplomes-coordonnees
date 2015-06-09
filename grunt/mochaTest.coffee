module.exports =
  test:
    options:
      reporter: 'spec',
      require: ['coffee-script/register']
      clearRequireCache: true
    src: ['server/**/*.spec.coffee']
  ignored:
    options:
      reporter: 'spec',
      require: ['coffee-script/register']
      clearRequireCache: true
    src: ['server/**/*.ignore.spec.coffee']
  couverture:
    options:
      reporter: 'html-cov'
      quiet: true
      require: ['coffee-coverage/register']
      captureFile: 'dist/public/couverture/index.html'
    src: ['server/**/*.spec.coffee']