import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Gdk from "gi://Gdk";
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
        if (visual)
          toplevel.set_visual(visual);
      }
      widget.set_app_paintable?.(true);
      widget.on("draw", (w, cr) => {
        cr.setOperator(Cairo.Operator.CLEAR);
        cr.paint();
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

function updateVisibility(corners) {
  const fullscreen = Hyprland.active.client?.fullscreen ?? false;
  corners.forEach(c => c.visible = !fullscreen);
}

export default () => {
  const corners = createCorners();
  updateVisibility(corners);
  Hyprland.connect("event", (_, name) => {
    if (name === "fullscreen") {
      updateVisibility(corners);
    }
  });
  return corners;
};
