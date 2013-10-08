module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    temp: "temp/"

    sources: [
        "sources/*.coffee",
        "sources/models/*.coffee",
        "sources/views/*.coffee",
        "sources/controllers/*.coffee"]

    # components: ["components/quojs/quo.js",
    #              "components/monocle/monocle.js",
    #              "components/lungo/lungo.js"]


    coffee:
      app  : files: "app/<%=pkg.name%>.js": "<%= sources %>"

    # concat:
    #   js:
    #     src: "<%= components.js %>" dest: "<%= %>"

    watch:
      coffee:
        files: ["<%= sources %>"]
        tasks: ["coffee:app"]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  # grunt.loadNpmTasks "grunt-contrib-concat"

  grunt.registerTask "default", [ "coffee"]
