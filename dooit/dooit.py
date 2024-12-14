from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup
from dooit.ui.api import DooitAPI

from themes import CatppuccinMocha
from formatters import custom_date_due


@subscribe(Startup)
def setup(api: DooitAPI, _):
    api.css.set_theme(CatppuccinMocha)


@subscribe(Startup)
def set_formatters(api: DooitAPI, _):
    fmt = api.formatter

    fmt.todos.due.add(custom_date_due, "custom_date_due")
