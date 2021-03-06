import logging
from datetime import date
from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException

from app.helpers.login_manager import PermissionRequired, login_required
from app.schemas.sche_user import UserItemResponse
from app.schemas.sche_work_schedule import (ConfirmWorkSchedule,
                                            ListWorkSchedule)
from app.services.srv_user import UserService
from app.services.srv_work_schedule import WorkScheduleService

logger = logging.getLogger()
router = APIRouter()

@router.post('/me', dependencies=[Depends(PermissionRequired('volunteer'))])
def upsert_work_schedule(request: ListWorkSchedule,
                         current_user: UserItemResponse = Depends(UserService().get_current_user)):
    for work_schedule in request.work_schedule:
        working_day = work_schedule.working_day
        if working_day is None:
            raise HTTPException(status_code=400, detail='working_day khong duoc de trong')

        working_shift = work_schedule.working_shift
        if working_shift and working_shift != 0 and working_shift != 1 and working_shift != 2:
            raise HTTPException(status_code=400, detail='working_shift chỉ nhận các giá trị 0, 1, 2')

        res = WorkScheduleService.is_exist_work_schedule(user_id=current_user['id'], working_day=working_day)
        if res:
            WorkScheduleService.update_work_schedule(user_id=current_user['id'], data=work_schedule)
        else:
            WorkScheduleService.register_work_schedule(user_id=current_user['id'], data=work_schedule)

@router.get('', dependencies=[Depends(PermissionRequired('admin'))])
def get_list_work_schedule(start_at: Optional[date] = None, end_at: Optional[date] = None):
    list_users = UserService.get_list_users_by_role(role='volunteer')
    users = []
    for user in list_users:
        u = WorkScheduleService.get_user_work_schedule(user_id=user.get('id'), start_at=start_at, end_at=end_at)
        if u.get('id') is None:
            u['id'] = user.get('id')
            u['full_name'] = user.get('first_name') + ' ' + user.get('last_name')
            u['total_shift'] = 0
        users.append(u)
    return {
        'users': users
    }

@router.get('/{user_id}', dependencies=[Depends(login_required)])
def get_work_schedule_by_user_id(user_id: int, start_at: Optional[date] = None, end_at: Optional[date] = None,
                                 current_user: UserItemResponse = Depends(UserService().get_current_user)):
    if current_user.get('role') != 'admin' and current_user.get('id') != user_id:
        raise HTTPException(status_code=400,
                            detail=f'User ' + current_user.get('username') + f' can not access this api')

    check_user = UserService.get_user_by_id(user_id=user_id)
    if check_user.get('role') != 'volunteer':
        raise HTTPException(status_code=400, detail="User is not volunteer")
    user = WorkScheduleService.get_user_work_schedule(user_id=user_id, start_at=start_at, end_at=end_at)
    if user.get('id') is None:
        user['id'] = check_user.get('id')
        user['full_name'] = check_user.get('first_name') + ' ' + check_user.get('last_name')
        user['total_shift'] = 0
    user['work_schedule'] = WorkScheduleService.get_list_work_schedule_by_user_id(user_id=user_id,
                                                                                  start_at=start_at, end_at=end_at)
    return user

