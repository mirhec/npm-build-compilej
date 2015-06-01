# Compile Java (for npm)
This is an extension to compile all java files found in your src directory. The dependencies listed in your config section will be set as classpath. This is useful if you want to use npm as your [build tool](http://blog.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/), e.g. to build your Java applications.

## General usage
If you have to specify some dependency jar files, do this in your `package.json` as follows:

```
"config": {
    "dependencies_dest": "lib/",
    "dependencies": [
      "some-dependency-3.4.5.jar"
    ]
}
```
For more information to this config settings visit [npm-build-dependencies](https://github.com/mirhec/npm-build-dependencies).

Furthermore you can specify the output build directory as well as the source directory (these are the default options if you don't set any of these paths):
```
"config": {
    "src": "src",
    "bin": "bin"
}
```

Then the only thing you have to do is creating a scripts part in your `package.json` in order to compile your Java files and add this extension into your dev-dependencies:

```
"devDependencies": {
    "build-compilej": "latest"
},
"scripts": {
    "dependencies": "build-compilej"
  }
```
