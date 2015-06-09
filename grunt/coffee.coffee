module.exports = {
  options: {
    sourceMap: true
  },
  client: {
    expand: true,
    cwd: '<%= repertoires.client %>app/',
    src: ['**/*.coffee'],
    dest: '<%= repertoires.distribution %>public/scripts',
    ext: '.js'
  },
  serveur: {
    expand: true,
    cwd: '<%= repertoires.serveur %>',
    src: ['**/*.coffee', '!**/*.spec.coffee'],
    dest: '<%= repertoires.distribution %>',
    ext: '.js'
  }
}