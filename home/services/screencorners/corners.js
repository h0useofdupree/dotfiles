import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Gdk from "gi://Gdk";
import GLib from "gi://GLib";
import Cairo from "gi://cairo?version=1.0";

const COLOR = { red: 0, green: 0, blue: 0, alpha: 1.0 };
const RADIUS = 20;
const dummyRegion = new Cairo.Region();

function clickthrough(win) {
  win.input_shape_combine_region(dummyRegion);
}

function CornerDrawing(position) {
  return Widget.DrawingArea({
    setup: (widget) => {
      widget.set_size_request(RADIUS, RADIUS);
      const toplevel = widget.get_toplevel();
      const screen = Gdk.Screen.get_default();
      if (toplevel && screen && screen.is_composited()) {
        const visual = screen.get_rgba_visual();
        if (visual) toplevel.set_visual(visual);
        toplevel.set_app_paintable(true);
      }

      widget.on("draw", (w, cr) => {
        // Clear entire area
        cr.setOperator(Cairo.Operator.CLEAR);
        cr.paint();

        // Draw only the rounded corner
        cr.setOperator(Cairo.Operator.OVER);
        switch (position) {
          case "topleft":
            cr.arc(RADIUS, RADIUS, RADIUS, Math.PI, 1.5 * Math.PI);
            cr.lineTo(0, 0);
            break;
          case "topright":
            cr.arc(0, RADIUS, RADIUS, 1.5 * Math.PI, 2 * Math.PI);
            cr.lineTo(RADIUS, 0);
            break;
          case "bottomleft":
            cr.arc(RADIUS, 0, RADIUS, 0.5 * Math.PI, Math.PI);
            cr.lineTo(0, RADIUS);
            break;
          case "bottomright":
            cr.arc(0, 0, RADIUS, 0, 0.5 * Math.PI);
            cr.lineTo(RADIUS, RADIUS);
            break;
        }
        cr.closePath();
        cr.setSourceRGBA(COLOR.red, COLOR.green, COLOR.blue, COLOR.alpha);
        cr.fill();
        return true;
      });
    },
  });
}

function CornerWindow(monitor, position) {
  const anchor = position.split(" ");
  const posKey = anchor.join("");

  return Widget.Window({
    monitor,
    name: `corner-${posKey}-${monitor}`,
    anchor,
    layer: "overlay",
    exclusivity: "ignore",
    visible: true,
    child: CornerDrawing(posKey),
    setup: clickthrough,
  });
}

function createCorners() {
  const display = Gdk.Display.get_default();
  const monitors = display ? display.get_n_monitors() : 1;
  const positions = ["top left", "top right", "bottom left", "bottom right"];

  return positions.flatMap(pos =>
    Array.from({ length: monitors }, (_, m) => CornerWindow(m, pos))
  );
}

function isReallyFullscreen(client) {
  const mon = Hyprland.monitors.find(m => m.name === client?.monitor);
  return mon
    && client
    && client.size[0] === mon.width
    && client.size[1] === mon.height;
}

function updateVisibility(corners) {
  const client = Hyprland.active.client;

  const isFullscreen = client?.fullscreen === "1" || isReallyFullscreen(client);
  const isFloating = client?.floating === true;

  const shouldHideCorners = isFullscreen || isFloating;

  for (const corner of corners) {
    if (shouldHideCorners) {
      App.closeWindow(corner.name);
    } else {
      App.openWindow(corner.name);
    }
  }
}

export default () => {
  const corners = createCorners();

  // Initial update once AGS is ready
  GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
    updateVisibility(corners);
    return GLib.SOURCE_REMOVE;
  });

  // Update when fullscreen state or window focus changes
  Hyprland.connect("event", (_, name) => {
    if (["fullscreen", "activewindow"].includes(name)) {
      updateVisibility(corners);
    }
  });

  return corners;
};
