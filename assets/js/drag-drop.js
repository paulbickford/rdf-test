// Create hooks for drag & drop. Follows:
// https://elixirforum.com/t/drag-drop-in-phoenix-liveview-custom-messages/21952/4

let Hooks = {};

Hooks.draggable = {
  mounted() {
    this.el.addEventListener("dragstart", e => {
      e.dataTransfer.dropEffect = "copy";
      e.dataTransfer.setData("text/plain", e.target.id);
    })
  }
}

Hooks.drop_zone = {
  mounted() {
    this.el.addEventListener("dragover", e => {
      e.preventDefault();
      e.dataTransfer.dropEffect = "copy";
    })

    this.el.addEventListener("drop", e => {
      e.preventDefault();
      const data = e.dataTransfer.getData("text/plain");
      this.pushEvent("drop-resource", { id: data })
    })
  }
}

export default Hooks;