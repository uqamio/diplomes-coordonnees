module.exports =
  dist:
    options:
      style: 'expanded',
      trace: false,
      loadPath: 'client/bower_components/foundation/scss/'
    files: [
        expand: true,
        cwd: '<%= repertoires.client %>assets/css/',
        src: ['**/*.scss'],
        dest: '<%= repertoires.distribution %>public/css/',
        ext: '.css'
    ]