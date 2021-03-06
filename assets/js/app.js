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
import PopupButtonHooks from './button-popup';
import DragDropHooks from './drag-drop';
import popupInputFocus from './popup-input-focus';

// Set up Hooks
// 
let Hooks = {};
Hooks = { ...Hooks, ...PopupButtonHooks, ...DragDropHooks };

// Set up LiveSocket
//
let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken }, hooks: Hooks
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


let init = (event) => {
  console.log("window load event triggered");
  // Focus input when popup is opened.
  popupInputFocus();
}

window.onload = init;

