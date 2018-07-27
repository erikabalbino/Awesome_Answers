/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Sometimes we want to import a file just to execute its contents
// without having to get a value in return. To do this, use the
// `import` syntax without a name or `for` as shown below:
import "../src/answer-delete";
import "../src/tooltip-for-questions";
// The above will execute the code in "../src/answer-delete"

// console.log('Hello World from Webpacker')


// Support component names relative to this directory:
var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)
