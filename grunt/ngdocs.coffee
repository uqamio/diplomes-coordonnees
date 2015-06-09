module.exports = {
  options: {
    dest: 'documentation/client',
    html5Mode: true,
    title: 'Documentation client'
  },
  api: {
    src: ['dist/public/scripts/**/*.js'],
    title: 'API Documentation'
  }
};