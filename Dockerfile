FROM python:3.8.12-buster

WORKDIR /production

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY dummy_calculator dummy_calculator
COPY setup.py setup.py
RUN pip install .

CMD uvicorn dummy_calculator.dummy_calculator:api --host 0.0.0.0 --port $PORT
