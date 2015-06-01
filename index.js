var env = process.env;
var glob = require('glob');
var exec = require('child_process').execFileSync;
var mkdir = require('fs').mkdirSync;

module.exports = function compileJ() {
    // collect variables
    var src = env.npm_package_config_src != undefined ? env.npm_package_config_src : 'src';
    var bin = env.npm_package_config_bin != undefined ? env.npm_package_config_bin : 'bin';

    // build dependencies
    var i = 0;
    var deps = [];
    while(true) {
        var n = env['npm_package_config_dependencies_' + i];
        if(n !== undefined) {
            deps.push(env.npm_package_config_dependencies_dest + n);
        } else {
            break;
        }
        i++;
    }

    // collect list of *.java files
    var javaFiles = glob.sync(src + '/**/*.java');

    // execute javac
    mkdir(bin + '/classes');
    exec('javac', ['-sourcepath', src, '-cp', deps.join(';'), '-d', bin + '/classes'].concat(javaFiles));
}
