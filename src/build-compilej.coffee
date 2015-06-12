env = process.env
glob = require 'glob'
exec = require('child_process').spawnSync
colors = require 'colors'
fs = require 'fs'

module.exports = compileJ = () ->
    # collect variables
    src = env.npm_package_config_src ? 'src'
    bin = env.npm_package_config_bin ? 'bin'

    # build dependencies
    i = 0
    deps = []
    while true
        n = env['npm_package_config_dependencies_' + i]
        if n?
            deps.push env.npm_package_config_dependencies_dest + n
        else
            break
        i++

    # collect list of *.java files
    javaFiles = glob.sync src + '/**/*.java'

    # execute javac
    if !fs.existsSync bin
        fs.mkdirSync bin
    if !fs.existsSync bin + '/classes'
        fs.mkdirSync bin + '/classes'
    ret = exec 'javac', ['-sourcepath', src, '-cp', deps.join '', '-d', bin + '/classes'].concat(javaFiles),
        stdio: [
          0, # stdin
          0, # stdout, e.g. 'pipe'
          fs.openSync 'build-compilej.log', 'w' # direct child's stderr to a file
        ]
    if ret.status == 0
        console.log 'build:compilej :: ' + 'Ok'.green + '.'
    else
        console.log 'build:compilej :: ' + 'Errors'.red + '! (Logfile: build-compilej.log)'
