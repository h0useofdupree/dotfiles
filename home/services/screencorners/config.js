"use strict";

import App from "resource:///com/github/Aylur/ags/app.js";
import CreateCorners from "./corners.js";

App.config({
  stackTraceOnError: true,
  windows: CreateCorners(),
});
