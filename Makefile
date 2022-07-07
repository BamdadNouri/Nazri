HOST=127.0.0.1
TEST_PATH=./
PROJECT_NAME="delta"

clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	name '*~' -exec rm --force  {}

isort:
	- isort --skip-glob=.tox --reverse-sort --profile=black .

flake8:
	- flake8 --exclude='.tox' --exclude='__init__.py' --extend-exclude='*_pb2*.py' .

blue:
	- blue .

lint: isort blue flake8

test:
	python manage.py test .

run:
	python manage.py runserver

docker-run:
	docker build \
	  --file=./Dockerfile \
	  --tag=$(PROJECT_NAME) ./
	docker run \
	  --detach=false \
	  --name=$(PROJECT_NAME) \
	  --publish=$(HOST):8080 \
	  $(PROJECT_NAME)
