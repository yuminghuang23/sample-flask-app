APP_NAME=easycrm
WEB_APP_TEMPLATE_NAME=web-app
S3_TEMPLATE_NAME=s3-bucket
ENVIRONMENT_NAME=dev
S3_BUCKET_PATH=sample-elastic-beanstalk-bucket-ap-southeast-2

build:
	docker build -t ${APP_NAME} .

test: build
	docker run -e CI=true ${APP_NAME} nosetests -v

run-local:
	docker run -p 8090:8090 ${APP_NAME}

valid-cf:
	aws cloudformation validate-template --region ap-southeast-2 --template-body file://cloudformation/${WEB_APP_TEMPLATE_NAME}.cf.yaml
	aws cloudformation validate-template --region ap-southeast-2 --template-body file://cloudformation/${S3_TEMPLATE_NAME}.cf.yaml

deploy-s3-cf:
	aws cloudformation deploy \
		--template-file ./cloudformation/$(S3_TEMPLATE_NAME).cf.yaml \
		--stack-name $(S3_TEMPLATE_NAME)-$(ENVIRONMENT_NAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides ${shell cat config/$(ENVIRONMENT_NAME).conf}
		--no-fail-on-empty-changeset

push-code-to-s3:
	zip -r ${WEB_APP_TEMPLATE_NAME}.zip .
	aws s3 cp ${WEB_APP_TEMPLATE_NAME}.zip s3://${S3_BUCKET_PATH}/${WEB_APP_TEMPLATE_NAME}.zip

deploy-elasticbean-stalk-cf:
	aws cloudformation deploy \
		--template-file ./cloudformation/$(WEB_APP_TEMPLATE_NAME).cf.yaml \
		--stack-name $(WEB_APP_TEMPLATE_NAME)-$(ENVIRONMENT_NAME) \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides ${shell cat config/$(ENVIRONMENT_NAME).conf}
		--no-fail-on-empty-changeset
