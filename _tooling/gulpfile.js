const { src, dest, watch, series, parallel } = require('gulp');
const tap = require('gulp-tap')
const del = require('del');

const convertToHtml = require('./convert-to-html');
const browsersync = require("browser-sync").create();

function addRevealCssDependencies(cb) {
    return src('node_modules/reveal.js/dist/**')
        .pipe(dest('build/dist/node_modules/reveal.js/dist'))
    cb();
}

function addRevealJsDependencies(cb) {
    return src('node_modules/reveal.js/{js,lib,plugin}/**/*.*')
        .pipe(dest('build/dist/node_modules/reveal.js'))
    cb();
}

function addRevealJsPlugins(cb) {
    return src('node_modules/reveal.js-menu/**/*.*')
        .pipe(dest('build/dist/plugins/reveal.js-menu'))
    cb();

}

function addNoJekyllForGithub(cb) {
    src('.nojekyll')
        .pipe(dest('build/dist'))
    cb();
}
const init = series(addRevealCssDependencies, addRevealJsDependencies, addNoJekyllForGithub, addRevealJsPlugins)

function convert(cb) {
    return src('build/**/*.adoc')
        .pipe(convertToHtml())
    cb();
}

function copyAdoc(cb) {
    src('slides/**/*.adoc')
        .pipe(dest('build/dist'))
    cb();
}

function copyStatics(cb) {
  src('slides/**/*.{svg,png,jpg,jpeg,gif,webp,css,js}')
    .pipe(dest('build/dist'))
    cb();
}

function copyPlugins(cb) {
    return src('slides/plugins/**/*.*')
        .pipe(dest('build/dist/plugins/'))
    cb();
}

function copyProvidedHtml(cb) {
    src('slides/html/*.html')
      .pipe(dest('build/dist'))
      cb();
  }


const build = series(parallel(copyProvidedHtml, copyAdoc, copyStatics, copyPlugins), convert)

function watchFiles() {
    watch("slides/css/**/*", series(copyStatics, browserSyncStream))
    watch("slides/js/**/*", series(copyStatics, browserSyncReload))
    watch("slides/plugins/**/*", series(copyPlugins, browserSyncReload))
    watch("slides/images/**/*", series(copyStatics, browserSyncReload))
    watch("slides/html/**/*", series(build, browserSyncReload))
    watch('slides/**/*.adoc', series(build, browserSyncReload))
};

// BrowserSync
function browserSync(done) {
    browsersync.init({
      server: {
        baseDir: "./build/dist/"
      },
      notify: false,
      port: 3000
    });
    done();
}
function browserSyncReload(done) {
    browsersync.reload();
    done();
}
function browserSyncStream(done) {
    browsersync.reload();
    done();
}

exports.default = series(init, build)
exports.serve = series(init, build, parallel(watchFiles, browserSync))
