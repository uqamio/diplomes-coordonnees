

module.exports =
  (grunt) ->
    require('load-grunt-tasks') grunt

    require('load-grunt-config') grunt,
        data:
          repertoires:
            client: 'client/',
            serveur: 'server/',
            distribution: 'dist/',
            test: 'tests/'
          mochaTestSrc: 'server/**/*.spec.coffee'

    grunt.registerTask 'build',
      ['coffee',
       'copy',
       'injector',
       'wiredep']

    grunt.registerTask 'executerDev',
      ['env:dev',
       'express:dev',
       'open:dev',
       'watch']

    grunt.registerTask 'executerDebug',
      ['build',
       'env:dev',
       'express:dev',
       'open:debug',
       'open:dev',
       'node-inspector']

    grunt.registerTask 'deployDev',
      ['clean',
       'mochaTest:couverture'
       'coffee'
       'sass:dist',
       'copy',
       'injector',
       'wiredep',
       'open:couverture']

    grunt.registerTask 'deploy',
      ['clean',
       'coffee'
       'sass:dist',
       'copy',
       'injector',
       'wiredep']

    grunt.registerTask 'serve',
      (target) ->
        if target == 'dev'
          grunt.task.run([
            'clean',
            'sass:dist',
            'build',
            'executerDev'])
        else
          console.warn('Aucune cible de trouvé dans le démarage de grunt pour : «%s»', target)


    grunt.registerTask('default', ['serve:dev'])

    #On watch events, if the changed file is a test file then configure mochaTest to only
    #run the tests from that file. Otherwise run all the tests
    defaultTestSrc = grunt.config 'mochaTest.test.src'
    grunt.event.on 'watch', (action, filepath) ->
      grunt.config 'mochaTest.test.src', defaultTestSrc
      if (action is 'changed' and filepath.match('spec.coffee'))
        grunt.config 'mochaTest.test.src', filepath