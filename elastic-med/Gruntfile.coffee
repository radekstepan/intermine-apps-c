module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON("package.json")
        
        apps_c:
            commonjs:
                src: [ 'src/**/*.{coffee,mustache}' ]
                dest: 'build/js/em.js'
                options:
                    main: 'src/app.coffee'
                    name: 'em'

        stylus:
            compile:
                src: [ 'src/styles/app.styl' ]
                dest: 'build/css/em.css'

        concat:            
            scripts:
                src: [
                    # Vendor dependencies.
                    'vendor/jquery/jquery.js'
                    'vendor/lodash/dist/lodash.js'
                    'vendor/canjs/can.jquery.js'
                    'vendor/elasticsearch/index.js'
                    'vendor/moment/moment.js'
                    'vendor/colorbrewer/colorbrewer.js'
                    'vendor/d3/d3.js'
                    # Our app.
                    'build/js/em.js'
                ]
                dest: 'build/js/em.bundle.js'
                options:
                    separator: ';' # for minification purposes

            styles:
                src: [
                    'vendor/foundation/css/normalize.css'
                    'vendor/foundation/css/foundation.css'
                    'vendor/hint.css/hint.css'
                    'vendor/font-awesome/css/font-awesome.css'
                    'src/styles/fonts.css'
                    'build/css/em.css'
                ]
                dest: 'build/css/em.bundle.css'

        copy:
            fonts:
                src: [ 'vendor/font-awesome/fonts/*' ]
                dest: 'build/fonts/'
                expand: yes
                flatten: yes

    grunt.loadNpmTasks('grunt-apps-c')
    grunt.loadNpmTasks('grunt-contrib-stylus')
    grunt.loadNpmTasks('grunt-contrib-concat')
    grunt.loadNpmTasks('grunt-contrib-copy')

    grunt.registerTask('default', [
        'apps_c'
        'stylus'
        'concat'
        'copy'
    ])