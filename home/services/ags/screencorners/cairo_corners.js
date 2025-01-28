import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Cairo from "gi://cairo?version=1.0";
import Gdk from "gi://Gdk";

export function RoundedCorner(position) {
  const COLOR = { red: 0, green: 0, blue: 0, alpha: 1.0 };
  const RADIUS = 20;

  return Widget.DrawingArea({
    setup: (widget) => {
      // 1) Request the desired size
      widget.set_size_request(RADIUS, RADIUS);

      // 2) Make sure the parent window (toplevel) uses an RGBA (translucent) visual
      //    so alpha is respected.
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

      // 3) Optionally, mark ourselves as paintable (often helpful)
      widget.set_app_paintable?.(true);

      // 4) Connect draw signal with .on(...) – connections[] are deprecated
      widget.on("draw", (w, cr) => {
        //
        // A) Clear the entire background by painting with Operator.CLEAR
        //    to ensure everything is fully transparent initially.
        //
        cr.setOperator(Cairo.Operator.CLEAR);
        cr.paint();

        // B) Switch back to normal compositing mode
        cr.setOperator(Cairo.Operator.OVER);

        // C) Draw the corner arc
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

        // Returning true stops further draw handling
        return true;
      });
    },
  });
}
