from datetime import date

from pydantic import BaseModel


class WorkScheduleRegister(BaseModel):
    working_day: date
    working_shift: int