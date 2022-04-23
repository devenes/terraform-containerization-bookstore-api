FROM python:alpine
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 80
CMD python ./app.py
# Don't use CMD python ./bookstore-api.py
# because I changed the name of the file to app.py
# in the Curl command in user-data.sh
