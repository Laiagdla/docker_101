from fastapi import FastAPI

api = FastAPI()

# Define a root `/` endpoint
@api.get('/')
def index():
    return {'status': 'Online'}

@api.get('/calc')
def calc(x: int, y: int):
    return { 'result' : x + y,
            'feeling exited?' : '😎 yeah!'}
