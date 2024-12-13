from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup

from dooit.api.theme import DooitThemeBase


class CatppuccinMocha(DooitThemeBase):
    _name = "Catppuccin Mocha"

    background1: str = "#1e1e2e"  # Darkest
    background2: str = "#3B4252"  # Lighter
    background3: str = "#434C5E"  # Lightest

    # foreground colors
    foreground1: str = "#cdd6f4"  # Darkest
    foreground2: str = "#E5E9F0"  # Lighter
    foreground3: str = "#ECEFF4"  # Lightest

    # other colors
    red: str = "#f38ba8"
    orange: str = "#fab387"
    yellow: str = "#f9e2af"
    green: str = "#a6e3a1"
    blue: str = "#89b4fa"
    purple: str = "#cba6f7"
    magenta: str = "#f5c2e7"
    cyan: str = "#74c7ec"

    # accent colors
    primary: str = purple
    secondary: str = blue


@subscribe(Startup)
def setup(api: DooitAPI, _):
    api.css.set_theme(CatppuccinMocha)
