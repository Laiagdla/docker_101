
############### build and run locally ####################3
build-local:
	docker build -t dummy_calculator:dev .

run-local:
	docker run -p 8000:8000 --env-file .env dummy_calculator:dev

run-interactive:
	docker run -it -p 8000:8000 --env-file .env dummy_calculator:dev sh


############## register and authorize Gcloud Artifact Registry ############3
gcloud-auth:
	gcloud auth configure-docker ${GCP_REGION}-docker.pkg.dev

gcloud-register-artifact:
	gcloud artifacts repositories create ${GAR_REPO} --repository-format=docker \
	--location=${GCP_REGION} --description="Repository for storing dummy_calculator images"


############# building and pushing to Gcloud Artifact Registry ############3
build-gcloud:
	docker build -t ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${GAR_REPO}/${GAR_IMAGE}:prod .

build-test-gcloud:
	docker run -p 8000:8000 --env-file .env ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${GAR_REPO}/${GAR_IMAGE}:prod

push:
	docker push ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${GAR_REPO}/${GAR_IMAGE}:prod


############# deploy to Google cloud Run #################################3
deploy:
	gcloud run deploy --image ${GCP_REGION}-docker.pkg.dev/${GCP_PROJECT}/${GAR_REPO}/${GAR_IMAGE}:prod \
	--memory ${GAR_MEMORY} --region ${GCP_REGION} --env-vars-file .env.yaml --allow-unauthenticated


############ manage Google Cloud Run #####################################3
status:
	gcloud run services list

stop-gcloud:
	gcloud run services delete ${GAR_IMAGE}
