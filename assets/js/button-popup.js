/* Popup button script to be used in conjunction with
  the mixin 'button-popup' in '_buttons.scss'.

  CSS cannot be used alone to transition from the original
  width of the button to its contracted state, because 
  CSS requires the initial width to be set explicitly in 
  length units (not 'auto', 'min-content',...). Since the
  width will vary depending on the length of the labels used,
  the initial width cannot be determined in CSS.

  Adapted from:
  https://css-tricks.com/using-css-transitions-auto-dimensions/ */

function shrinkPopupButton(element, checkbox, widths) {
  // Temporarily disable all CSS transitions.
  let elementTransition = element.style.transition;
  element.style.transition = '';

  // On the next frame (as soon as the previous style change 
  // has taken effect), explicitly set the element's width to
  // its current pixel width, so we aren't transitioning out of 'auto'.
  requestAnimationFrame(() => {
    element.style.width = widths.max;
    element.style.transition = elementTransition;

    // On the next frame (as soon as the previous style change
    // has taken effect), have the element transition to new width.
    requestAnimationFrame(() => {
      element.style.width = widths.min;
    });
  });

  checkbox.setAttribute('checked', 'true');
}

function expandPopupButton(element, checkbox, widths) {

  // Set the target width for the element transition.
  element.style.width = widths.max;

  // When the next CSS transition finishes (which should be the
  // one we just triggered).
  const handleTransitionEnd = () => {

    // Remove width from the element's inline styles, so it can
    // return to its initial value.
    element.style.width = null

    // Remove this event listener so it only gets triggered once.
    element.removeEventListener('transitionend', handleTransitionEnd);
  }
  element.addEventListener('transitionend', handleTransitionEnd);

  checkbox.setAttribute('checked', 'false');
}

// Add each popup button here.
const popupButtonWidths = { 'resources': { max: 0, min: 0 } };

// Create hook and export it.
let Hooks = {};
for (const buttonClass in popupButtonWidths) {
  Hooks[buttonClass + 'PopupButton'] = {
    mounted() {
      const button = document.getElementById(buttonClass + '-button-popup');
      popupButtonWidths[buttonClass].max = button.clientWidth + 'px';
      popupButtonWidths[buttonClass].min = getComputedStyle(button).getPropertyValue('--button-popup-min-width');

      document.getElementById(buttonClass + '-toggle').addEventListener('change', (e) => {
        const checkbox = document.getElementById(buttonClass + '-toggle');
        const isChecked = checkbox.getAttribute('checked') === 'true';

        if (isChecked) {
          expandPopupButton(button, checkbox, popupButtonWidths[buttonClass])
        } else {
          shrinkPopupButton(button, checkbox, popupButtonWidths[buttonClass])
        }
      });
    }
  }
};

export default Hooks;
