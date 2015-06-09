module.exports = {
  clientApp: {
    files: [
      {
        expand: true,
        cwd: '<%= repertoires.client %>',
        src: [
          '**/*.html',
          'bower_components/**/*',
          '*.ico'
        ],
        dest: '<%= repertoires.distribution %>public/'
      },
      {
        expand: true,
        cwd: '<%= repertoires.client %>assets',
        src: [
          'images/**/*{.png,.jpg}'
        ],
        dest: '<%= repertoires.distribution %>public/'
      }
    ]
  }
};