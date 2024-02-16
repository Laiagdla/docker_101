from fastapi import FastAPI
from dummycalculator.dummy_db import something_in_a_list

api = FastAPI()

# Define a root `/` endpoint
@api.get('/')
def index():
    return {'status': 'Online'}

@api.get('/calc')
def calc(x: int, y: int):
    return { 'result' : x + y,
             'feeling exited?' : '😎 yeah!'}


if __name__ == '__main__':
    print('Starting the dummy calculator API')
    print(something_in_a_list)
