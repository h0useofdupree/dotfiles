"use strict";

import Gdk from "gi://Gdk";
import App from "resource:///com/github/Aylur/ags/app.js";
import Corner from "./screencorners/main.js";

function range(length, start = 0) {
  return Array.from({ length }, (_, i) => i + start);
}

function forMonitors(widget) {
  const display = Gdk.Display.get_default();
  const n = display ? display.get_n_monitors() : 1;
  return range(n, 0).map(widget).flat(1);
}

const Windows = () =>
  [
    // Create corners for all monitors (top-left, top-right, bottom-left, bottom-right)
    forMonitors((id) => Corner(id, "top left", true)),
    forMonitors((id) => Corner(id, "top right", true)),
    forMonitors((id) => Corner(id, "bottom left", true)),
    forMonitors((id) => Corner(id, "bottom right", true)),
  ].flat(1);

App.config({
  stackTraceOnError: true,
  windows: Windows(),
});
