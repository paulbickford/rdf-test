// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
// import css from '../css/app.css';
import sass from '../css/app.scss';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import { MDCRipple } from '@material/ripple';
import { MDCTopAppBar } from '@material/top-app-bar';


MDCRipple.attachTo(document.querySelector('.navlink'));

const topAppBar = MDCTopAppBar.attachTo(document.getElementById('app-bar'));
topAppBar.setScrollTarget(document.getElementById('main-content'));
topAppBar.listen('MDCTopAppBar:nav', () => {
  drawer.open = !drawer.open;
});

const iconButtonRipple = MDCRipple(document.querySelector('.mdc-icon-button'));
iconButtonRipple.unbound = true;
