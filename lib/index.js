#!/usr/bin/env node
'use strict';

var _commander = require('commander');

var _commander2 = _interopRequireDefault(_commander);

var _fsExtra = require('fs-extra');

var _nodeElmCompiler = require('node-elm-compiler');

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _shelljs = require('shelljs');

var _shelljs2 = _interopRequireDefault(_shelljs);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

_asyncToGenerator(function* () {
  _commander2.default
  // package.json is one level up because the compiled js file is in lib/
  // eslint-disable-next-line import/no-unresolved
  .version(require(_path2.default.resolve(__dirname, '../package.json')).version).usage('[options] <file> [arg1 arg2 ...]').description('Runs an Elm file and prints the result of `output` to stdout.' + ' `output` can be a constant of type `String` or a function that accepts `List String` and returns `String`. You can supply command line arguments to the Elm file if `output` accepts `List String`.').option('--output-name [name]', 'constant or function name for printing results', 'output').option('--project-dir [path]', 'specific directory to search for elm-package.json or to create it (if different from Elm file location)').option('--report [format]', 'Format of error and warning reports (e.g. --report=json)', 'normal').parse(process.argv);

  // run-elm expects one or more arguments, so exit if no arguments given
  if (_commander2.default.args.length === 0) {
    console.log(_commander2.default.help());
    process.exit(1);
  }

  // read args and options
  const rawUserModuleFileName = _commander2.default.args[0];
  const outputName = _commander2.default.outputName;
  const rawProjectDir = _commander2.default.projectDir;
  const reportFormat = _commander2.default.report;
  const argsToOutput = _commander2.default.args.slice(1);

  // extract key paths
  const timestamp = +new Date();
  const mainModule = `RunElmMain${timestamp}`;
  const templatePath = _path2.default.resolve(__dirname, 'RunElmMain.elm.template');
  const templateWithArgsPath = _path2.default.resolve(__dirname, 'RunElmMainWithArgs.elm.template');
  const userModulePath = _path2.default.resolve(rawUserModuleFileName);
  const userModule = _path2.default.basename(userModulePath, '.elm');
  const projectDir = rawProjectDir ? _path2.default.resolve(rawProjectDir) : _path2.default.resolve(_path2.default.dirname(userModulePath));
  const mainModuleFilename = _path2.default.join(projectDir, `${mainModule}.elm`);
  const outputCompiledFilename = _path2.default.join(projectDir, `run-elm-main-${timestamp}.js`);

  let exitCode = 0;
  try {
    // ensure elm is installed
    if (!_shelljs2.default.which('elm')) {
      throw new Error('No elm global binary available. Please install with `npm install -g elm`.');
    }

    // ensure --output-name is specified adequately
    if (!outputName.match(/^[a-z_]\w*$/)) {
      throw new Error(`Provided --output-name \`${outputName}\` is not a valid constant or function name in elm.`);
    }
    if (['init', 'main', 'program', 'sendOutput'].includes(outputName)) {
      throw new Error(`It is not allowed to use \`${outputName}\` as a value for --output-name. Please rename the variable you would like to output.`);
    }

    // ensure user module path is adequate
    try {
      const userModuleFileStats = yield (0, _fsExtra.stat)(userModulePath);
      if (!userModuleFileStats.isFile()) {
        throw new Error();
      }
    } catch (err) {
      throw new Error(`File \`${userModulePath}\` does not exist.`);
    }
    if (!userModulePath.match(/\.elm$/i, '')) {
      throw new Error(`File \`${userModulePath}\` should have .elm file extension.`);
    }

    // ensure project folder is adequate
    try {
      const projectDirStats = yield (0, _fsExtra.stat)(projectDir);
      if (!projectDirStats.isDirectory()) {
        throw new Error();
      }
    } catch (err) {
      throw new Error(`Provided --project-dir \`${rawProjectDir}\` is not a directory.`);
    }
    if (userModulePath.indexOf(`${projectDir}/`) !== 0) {
      throw new Error(`File \`${userModulePath}\` must be located within --project-dir \`${rawProjectDir}\``);
    }

    // ensure report format is adequate
    if (!['normal', 'json'].includes(reportFormat)) {
      throw new Error(`It is not allowed to use \`${reportFormat}\` as a value for --report. Please use \`normal\` or \`json\`.`);
    }

    // read user module and determine what template to use
    let userModuleContents;
    try {
      userModuleContents = yield (0, _fsExtra.readFile)(userModulePath, 'utf-8');
    } catch (err) {
      throw new Error(`File '${userModulePath}' could not be read`);
    }
    const argsRegex = new RegExp(`^${outputName} +\\w+ *=`);
    const needArgs = userModuleContents.split('\n').some(function (line) {
      return argsRegex.test(line.trim());
    });

    // read main module template
    _shelljs2.default.cd(projectDir);
    let template;
    const chosenTemplatePath = needArgs ? templateWithArgsPath : templatePath;
    try {
      template = yield (0, _fsExtra.readFile)(chosenTemplatePath, 'utf-8');
    } catch (err) {
      throw new Error(`Elm file '${chosenTemplatePath}' does not exist`);
    }

    // create main module file from template
    const mainModuleContents = template.replace('{mainModule}', mainModule).replace('{userModule}', userModule).replace(/\{output\}/g, outputName);
    yield (0, _fsExtra.writeFile)(mainModuleFilename, mainModuleContents, 'utf-8');

    // compile main module
    const contents = yield (0, _nodeElmCompiler.compileToString)([mainModuleFilename], {
      yes: true,
      report: reportFormat
    });
    yield (0, _fsExtra.writeFile)(outputCompiledFilename, contents);

    // run compiled elm file
    yield new Promise(function (resolve) {
      const worker = require(outputCompiledFilename)[mainModule].worker;

      const app = needArgs ? worker(argsToOutput) : worker();
      app.ports.sendOutput.subscribe(function (output) {
        console.log(output);
        resolve();
      });
    });
  } catch (err) {
    // handle error
    let message;
    if (typeof err === 'object' && 'message' in err) {
      if (err.message.indexOf(`does not expose \`${outputName}\``) !== -1) {
        message = `Elm file \`${userModulePath}\` does not define \`${outputName}\``;
      } else if (err.message.indexOf(`I cannot find module '${userModule}'`) !== -1) {
        message = `Elm file \`${userModulePath}\` cannot be reached from --project-dir \`${projectDir}\`. Have you configured \`source-directories\` in elm-package.json?`;
      } else {
        message = err.message;
      }
    } else {
      message = err;
    }
    console.error('Error:', message);
    if (err.stack && process.env.DEBUG) {
      console.error(err.stack.substring(err.toString().length + 1));
    }
    exitCode = 1;
  } finally {
    // cleanup
    yield Promise.all([(0, _fsExtra.unlink)(mainModuleFilename).catch(function () {}), (0, _fsExtra.unlink)(outputCompiledFilename).catch(function () {})]);
  }

  // do not call process.exit(0) to avoid stdout truncation
  // https://github.com/nodejs/node/issues/6456
  if (exitCode) {
    process.exit(exitCode);
  }
})();