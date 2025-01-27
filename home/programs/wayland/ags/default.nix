{inputs, ...}: {
  imports = [inputs.ags.homeManagerModules.default];
  home = {
    # 2) Place config.js in ~/.config/ags
    file.".config/ags/config.js".text = ''
      "use strict";

      import Gdk from 'gi://Gdk';
      import App from 'resource:///com/github/Aylur/ags/app.js';
      import Corner from './screencorners/main.js';

      function range(length, start = 0) {
        return Array.from({ length }, (_, i) => i + start);
      }

      function forMonitors(widget) {
        const display = Gdk.Display.get_default();
        const n = display ? display.get_n_monitors() : 1;
        return range(n, 0).map(widget).flat(1);
      }

      const Windows = () => [
        // One window per corner per monitor
        forMonitors((id) => Corner(id, 'top left', true)),
        forMonitors((id) => Corner(id, 'top right', true)),
        forMonitors((id) => Corner(id, 'bottom left', true)),
        forMonitors((id) => Corner(id, 'bottom right', true)),
      ].flat(1);

      App.config({
        stackTraceOnError: true,
        windows: Windows(),
      });
    '';

    # 3) Place main.js in ~/.config/ags/screencorners
    file.".config/ags/screencorners/main.js".text = ''
      import Widget from "resource:///com/github/Aylur/ags/widget.js";
      import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
      import App from "resource:///com/github/Aylur/ags/app.js";
      import Cairo from "gi://cairo?version=1.0";
      import { RoundedCorner } from "./cairo_corners.js";

      const dummyRegion = new Cairo.Region();
      function enableClickthrough(self) {
        self.input_shape_combine_region(dummyRegion);
      }

      // Hide/Show corners on fullscreen
      Hyprland.connect("event", (service, name, data) => {
        if (name === "fullscreen") {
          const monitor = Hyprland.active.monitor.id;
          if (data === "1") {
            // Window went fullscreen
            for (const window of App.windows) {
              if (window.name.startsWith("corner") && window.name.endsWith(monitor)) {
                App.closeWindow(window.name);
              }
            }
          } else {
            // Exited fullscreen
            for (const window of App.windows) {
              if (window.name.startsWith("corner") && window.name.endsWith(monitor)) {
                App.openWindow(window.name);
              }
            }
          }
        }
      });

      // Create a corner Window on the given monitor/position
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
    '';

    # 4) Place cairo_corners.js in ~/.config/ags/screencorners
    file.".config/ags/screencorners/cairo_corners.js".text = ''
      import Widget from "resource:///com/github/Aylur/ags/widget.js";
      import Cairo from "gi://cairo?version=1.0";
      import Gdk from "gi://Gdk";

      export function RoundedCorner(position) {
        const COLOR = { red: 0, green: 0, blue: 0, alpha: 1.0 };
        const RADIUS = 20;

        return Widget.DrawingArea({
          setup: (widget) => {
            // set size
            widget.set_size_request(RADIUS, RADIUS);

            // Use RGBA visual so the corners around the arc are transparent
            const toplevel = widget.get_toplevel();
            if (toplevel) {
              const screen = Gdk.Screen.get_default();
              if (screen && screen.is_composited()) {
                const visual = screen.get_rgba_visual();
                if (visual) {
                  toplevel.set_visual(visual);
                }
              }
            }

            // connect the 'draw' signal
            widget.on("draw", (w, cr) => {
              // Clear background
              cr.setOperator(Cairo.Operator.CLEAR);
              cr.paint();
              cr.setOperator(Cairo.Operator.OVER);

              switch (position) {
                case "topleft":
                  cr.arc(RADIUS, RADIUS, RADIUS, Math.PI, (3 * Math.PI) / 2);
                  cr.lineTo(0, 0);
                  break;
                case "topright":
                  cr.arc(0, RADIUS, RADIUS, (3 * Math.PI) / 2, 2 * Math.PI);
                  cr.lineTo(RADIUS, 0);
                  break;
                case "bottomleft":
                  cr.arc(RADIUS, 0, RADIUS, Math.PI / 2, Math.PI);
                  cr.lineTo(0, RADIUS);
                  break;
                case "bottomright":
                  cr.arc(0, 0, RADIUS, 0, Math.PI / 2);
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
    '';
  };
}
