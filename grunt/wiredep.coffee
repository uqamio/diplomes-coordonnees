module.exports = {
  target: {
    src: ['<%= repertoires.distribution %>public/index.html'],
    ignorePath: '../../<%= repertoires.client %>',
    exclude: ['foundation.css']
  }
};