import logging
from typing import List, Optional

from fastapi import APIRouter, Depends, File, Form, HTTPException, UploadFile

from app.helpers.login_manager import PermissionRequired
from app.schemas.sche_pet import PetInfoRequest, Urls
from app.services.srv_pet import PetService

logger = logging.getLogger()
router = APIRouter()


@router.post('', dependencies=[Depends(PermissionRequired('admin', 'volunteer'))])
def create_pet(name: str = Form(...),
               age: str = Form(...),
               gender: str = Form(...),
               color: str = Form(...),
               health_condition: str = Form(...),
               weight: float = Form(...),
               species: str = Form(...),
               description: str = Form(...),
               images: List[UploadFile] = File(...)):

    exist_pet = PetService.is_exist_pet(name=name)
    if exist_pet:
        raise HTTPException(status_code=400, detail='Pet name is already exist')

    if species != 'cat' and species != 'dog':
        raise HTTPException(status_code=400, detail='species chỉ nhận các giá trị cat, dog')
    if age != 'young' and age != 'mature' and age != 'old':
        raise HTTPException(status_code=400, detail='age chỉ nhận các giá trị young, mature, old')
    if gender != 'male' and gender != 'female':
        raise HTTPException(status_code=400, detail='gender chỉ nhận các giá trị male, female')

    pet_info = {
        'name': name,
        'age': age,
        'gender': gender,
        'color': color,
        'health_condition': health_condition,
        'weight': weight,
        'species': species,
        'description': description
    }
    PetService.create_pet(data=pet_info)

    pet_id = PetService.is_exist_pet(name=name)['id']
    for image in images:
        file_name = " ".join(image.filename.strip().split())
        file_ext = file_name.split('.')[-1]
        if file_ext.lower() not in ('jpg', 'png', 'jpeg'):
            raise HTTPException(status_code=400, detail='Can not upload file ' + image.filename)
        PetService.upload_pet_image(pet_id=pet_id, image=image.file)

    return {
        "pet_id": pet_id
    }

@router.get('')
def get_list_pets(species: Optional[str] = None, age: Optional[str] = None, gender: Optional[str] = None):
    pets = PetService.get_list_pets(species=species, age=age, gender=gender)
    for pet in pets:
        images = PetService.get_pet_images(pet_id=pet.get('id'))
        pet['images'] = images
    return {
        'pets': pets
    }

@router.get('/{pet_id}')
def get_pet_by_id(pet_id: int):
    pet = PetService.get_pet_by_id(pet_id=pet_id)
    if pet is None:
        raise HTTPException(status_code=400, detail='Pet not found')
    pet['images'] = PetService.get_pet_images(pet_id=pet_id)
    return pet

@router.put('/{pet_id}', dependencies=[Depends(PermissionRequired('admin', 'volunteer'))])
def update_pet_info(pet_id: int, pet_info: PetInfoRequest):
    pet = get_pet_by_id(pet_id=pet_id)

    if pet_info.name is None:
        pet_info.name = pet.get('name')
    else:
        if pet.get('name') != pet_info.name:
            exist_pet = PetService.is_exist_pet(name=pet_info.name)
            if exist_pet:
                raise HTTPException(status_code=400, detail='Pet name is already exist')

    if pet_info.age is None:
        pet_info.age = pet.get('age')
    if pet_info.color is None:
        pet_info.color = pet.get('color')
    if pet_info.health_condition is None:
        pet_info.health_condition = pet.get('health_condition')
    if pet_info.weight is None:
        pet_info.weight = pet.get('weight')
    if pet_info.description is None:
        pet_info.description = pet.get('description')
    if pet_info.species is None:
        pet_info.species = pet.get('species')
    if pet_info.gender is None:
        pet_info.gender = pet.get('gender')

    if pet_info.species != 'dog' and pet_info.species != 'cat':
        raise HTTPException(status_code=400, detail='species chỉ nhận các giá trị cat, dog')
    if pet_info.age != 'young' and pet_info.age != 'mature' and pet_info.age != 'old':
        raise HTTPException(status_code=400, detail='age chỉ nhận các giá trị young, mature, old')
    if pet_info.gender != 'male' and pet_info.gender != 'female':
        raise HTTPException(status_code=400, detail='gender chỉ nhận các giá trị male, female')

    PetService.update_pet_info(pet_id=pet_id, data=pet_info)

@router.delete('/{pet_id}', dependencies=[Depends(PermissionRequired('admin', 'volunteer'))])
def delete_pet(pet_id: int):
    PetService.delete_pet(pet_id=pet_id)

@router.post('/{pet_id}/images', dependencies=[Depends(PermissionRequired('admin', 'volunteer'))])
def upload_list_pet_images(pet_id: int, images: List[UploadFile] = File(...)):
    pet = PetService.get_pet_by_id(pet_id=pet_id)
    if pet is None:
        raise HTTPException(status_code=400, detail='Pet not found')

    urls = []
    for image in images:
        file_name = " ".join(image.filename.strip().split())
        file_ext = file_name.split('.')[-1]
        if file_ext.lower() not in ('jpg', 'png', 'jpeg'):
            raise HTTPException(status_code=400, detail='Can not upload file ' + image.filename)
        urls.append(PetService.upload_pet_image(pet_id=pet_id, image=image.file))
    return {
        'urls': urls
    }

@router.delete('/{pet_id}/images', dependencies=[Depends(PermissionRequired('admin', 'volunteer'))])
def delete_image(pet_id: int, req: Urls):
    for url in req.urls:
        PetService.delete_image(pet_id=pet_id, url=url)

