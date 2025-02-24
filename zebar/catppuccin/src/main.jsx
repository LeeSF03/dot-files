import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";
import * as zebar from "zebar";

const providers = zebar.createProviderGroup({
  keyboard: { type: "keyboard" },
  glazewm: { type: "glazewm" },
  cpu: { type: "cpu" },
  date: { type: "date", formatting: "EEE d MMM t" },
  battery: { type: "battery" },
  memory: { type: "memory" },
  weather: { type: "weather" },
  host: { type: "host" },
  media: { type: "media" },
  audio: { type: "audio" },
  network: { type: "network" },
});

createRoot(document.getElementById("root")).render(<App />);

function App() {
  const [output, setOutput] = useState(providers.outputMap);

  useEffect(() => {
    providers.onOutput(() => setOutput(providers.outputMap));
  }, []);

  function getBatteryIcon(batteryOutput) {
    if (batteryOutput.chargePercent > 90)
      return <i className="nf nf-fa-battery_4"></i>;
    if (batteryOutput.chargePercent > 70)
      return <i className="nf nf-fa-battery_3"></i>;
    if (batteryOutput.chargePercent > 40)
      return <i className="nf nf-fa-battery_2"></i>;
    if (batteryOutput.chargePercent > 20)
      return <i className="nf nf-fa-battery_1"></i>;
    return <i className="nf nf-fa-battery_0"></i>;
  }

  function getWeatherIcon(weatherOutput) {
    switch (weatherOutput.status) {
      case "clear_day":
        return <i className="nf nf-weather-day_sunny"></i>;
      case "clear_night":
        return <i className="nf nf-weather-night_clear"></i>;
      case "cloudy_day":
        return <i className="nf nf-weather-day_cloudy"></i>;
      case "cloudy_night":
        return <i className="nf nf-weather-night_alt_cloudy"></i>;
      case "light_rain_day":
        return <i className="nf nf-weather-day_sprinkle"></i>;
      case "light_rain_night":
        return <i className="nf nf-weather-night_alt_sprinkle"></i>;
      case "heavy_rain_day":
        return <i className="nf nf-weather-day_rain"></i>;
      case "heavy_rain_night":
        return <i className="nf nf-weather-night_alt_rain"></i>;
      case "snow_day":
        return <i className="nf nf-weather-day_snow"></i>;
      case "snow_night":
        return <i className="nf nf-weather-night_alt_snow"></i>;
      case "thunder_day":
        return <i className="nf nf-weather-day_lightning"></i>;
      case "thunder_night":
        return <i className="nf nf-weather-night_alt_lightning"></i>;
    }
  }

  return (
    <div className="app">
      <div className="left">
        <div className="box">
          <div className="logo">
            <i className="nf nf-custom-windows"></i>
          </div>
          <div>
            <button
              className="indicator-button"
              onClick={
                output.glazewm
                  ? () => output.glazewm.runCommand("wm-exit")
                  : null
              }
            >
              <i
                className={`nf nf-fa-circle_dot wm-indicator ${output.glazewm ? "on" : "off"}`}
              ></i>
            </button>
          </div>
          {output.glazewm &&
            output.glazewm.bindingModes.map((bindingMode) => (
              <button
                className="binding-mode"
                key={bindingMode.name}
                onClick={() =>
                  output.glazewm.runCommand(
                    `wm-disable-binding-mode --name ${bindingMode.name}`,
                  )
                }
              >
                {bindingMode.displayName ?? bindingMode.name}
              </button>
            ))}
        </div>
        {/* {output.glazewm && output.glazewm.focusedContainer.title && ( */}
        {/*   <div className="box window-title"> */}
        {/*     <div>{output.glazewm.focusedContainer.title}</div> */}
        {/*   </div> */}
        {/* )} */}
      </div>

      <div className="center">
        {output.glazewm && (
          <div className="box">
            <div className="workspaces">
              {output.glazewm.currentWorkspaces.map((workspace) => (
                <button
                  className={`workspace ${workspace.hasFocus && "focused"} ${workspace.isDisplayed && "displayed"}`}
                  onClick={() =>
                    output.glazewm.runCommand(
                      `focus --workspace ${workspace.name}`,
                    )
                  }
                  key={workspace.name}
                >
                  {workspace.displayName ?? workspace.name}
                </button>
              ))}
            </div>

            <button
              className={`tiling-direction nf ${output.glazewm.tilingDirection === "horizontal" ? "nf-md-swap_horizontal" : "nf-md-swap_vertical"}`}
              onClick={() =>
                output.glazewm.runCommand("toggle-tiling-direction")
              }
            ></button>
          </div>
        )}
      </div>

      <div className="right">
        <div className="box">
          {output.network && (
            <button
              className="network clean-button"
              onClick={() => output.glazewm.runCommand("shell-exec taskmgr")}
            >
              <i className="nf nf-md-download"></i>
              {output.network.traffic.received.siValue.toPrecision(3)}
              {output.network.traffic.received.siUnit}
            </button>
          )}

          {output.network && (
            <button
              className="network clean-button"
              onClick={() => output.glazewm.runCommand("shell-exec taskmgr")}
            >
              <i className="nf nf-md-upload"></i>
              {output.network.traffic.transmitted.siValue.toPrecision(3)}
              {output.network.traffic.transmitted.siUnit}
            </button>
          )}

          {output.memory && (
            <button
              className="memory clean-button"
              onClick={() => output.glazewm.runCommand("shell-exec taskmgr")}
            >
              <i className="nf nf-fa-memory"></i>
              {Math.round(output.memory.usage)}%
            </button>
          )}

          {output.cpu && (
            <button
              className="cpu clean-button"
              onClick={() => output.glazewm.runCommand("shell-exec taskmgr")}
            >
              <i className="nf nf-oct-cpu"></i>

              {/* Change the text color if the CPU usage is high. */}
              <span className={output.cpu.usage > 85 ? "high-usage" : ""}>
                {Math.round(output.cpu.usage)}%
              </span>
            </button>
          )}

          {output.battery && (
            <div className="battery">
              {/* Show icon for whether battery is charging. */}
              {output.battery.isCharging && (
                <i className="nf nf-md-lightning_bolt charging-icon"></i>
              )}
              {getBatteryIcon(output.battery)}
              {Math.round(output.battery.chargePercent)}%
            </div>
          )}

          {output.weather && (
            <div className="weather">
              {getWeatherIcon(output.weather)}
              {Math.round(output.weather.celsiusTemp)}°C
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
