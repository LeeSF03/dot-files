from datetime import datetime
from dooit.api import Todo


def custom_date_due(due: datetime, model: Todo) -> str:
    if due == None:
        return ""
    if due.year != datetime.today().year:
        return due.strftime("%b %d, %Y")
    else:
        return due.strftime("%b %d")
