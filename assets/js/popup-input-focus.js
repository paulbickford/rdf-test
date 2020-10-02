const popupInputFocus = () => {
  let addPopupCheckbox = document.getElementById("queries-add-toggle");
  addPopupCheckbox.addEventListener('change', e => {
    let checkbox = document.getElementById("queries-add-toggle");
    if (checkbox.checked) {
      document.querySelector(".queries-add__form-name").focus()
    }
  });
}

export default popupInputFocus;

