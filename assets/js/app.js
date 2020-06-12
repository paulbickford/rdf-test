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
import { Socket } from 'phoenix';
import LiveSocket from 'phoenix_live_view';
import NProgress from 'nprogress';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

// Import Material Design components
//
import { MDCRipple } from '@material/ripple';
import { MDCTopAppBar } from '@material/top-app-bar';
import { MDCDataTable } from '@material/data-table';

// Set up LiveSocket
//
let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
window.addEventListener('phx:page-loading-start', (info) => NProgress.start());
window.addEventListener('phx:page-loading-stop', (info) => NProgress.done());

// Connect if there are any LiveViews on the page.
liveSocket.connect();

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
// The latency simulator is enabled for the duration of the browser session.
// Call disableLatencySim() to disable:
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// Set up Material Design components
//
MDCRipple.attachTo(document.querySelector('.navlink'));

const topAppBar = MDCTopAppBar.attachTo(document.getElementById('app-bar'));
topAppBar.setScrollTarget(document.getElementById('main-content'));
topAppBar.listen('MDCTopAppBar:nav', () => {
  drawer.open = !drawer.open;
});

const iconButtonRipple = MDCRipple(document.querySelector('.mdc-icon-button'));
iconButtonRipple.unbound = true;

const dataTable = new MDCDataTable(document.querySelector('.mdc-data-table'));

// Select list item
// document.querySelector('ul').addEventListener('click', function (e) {
//   let selected;
//   if (e.target.tagName === 'LI') {
//     selected = document.querySelector('li.selected');
//     if (selected) selected.className = '';
//     e.target.className = 'selected';
//   }
// });
