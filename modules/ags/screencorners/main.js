import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Cairo from "gi://cairo?version=1.0";
import { RoundedCorner } from "./cairo_corners.js";

// Simple clickthrough logic (inlined here instead of a separate file)
const dummyRegion = new Cairo.Region();
function enableClickthrough(self) {
  self.input_shape_combine_region(dummyRegion);
}

// Listen for fullscreen events to hide/show corners
Hyprland.connect("event", (service, name, data) => {
  if (name === "fullscreen") {
    const monitor = Hyprland.active.monitor.id;
    // data == '1' means a window on that monitor just went fullscreen
    if (data === "1") {
      for (const window of App.windows) {
        if (window.name.startsWith("corner") && window.name.endsWith(monitor)) {
          App.closeWindow(window.name);
        }
      }
    } else {
      // data == '0' means fullscreen was exited
      for (const window of App.windows) {
        if (window.name.startsWith("corner") && window.name.endsWith(monitor)) {
          App.openWindow(window.name);
        }
      }
    }
  }
});

// Export a function that creates a corner Window on the given monitor/position
export default (monitor = 0, where = "bottom left", useOverlayLayer = true) => {
  const positionString = where.replace(/\s/, "");
  return Widget.Window({
    monitor,
    name: `corner${positionString}${monitor}`,
    layer: useOverlayLayer ? "overlay" : "top",
    anchor: where.split(" "),
    exclusivity: "ignore",
    visible: true,
    child: RoundedCorner(positionString),
    setup: enableClickthrough,
  });
};
