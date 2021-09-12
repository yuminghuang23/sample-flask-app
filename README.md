[![Build Status](https://github.com/yuminghuang23/sample-flask-app/actions/workflows/deploy.yaml/badge.svg)

# EasyCRM
Sample flask web app deployed to AWS Elastic Bean Stalk with CICD pipeline

**Originally Created by [Chris Hall](www.chrishall.io)**

**Modified by Yuming**

# Prerequisite

!!!!Attention!!!!This app only works with python:3.6.4

# Build and Run

```
make build 
```

```
make run-local
```

Now you can access http://0.0.0.0:8090/login/ with Username and Password: test@gmail.com/shh

# APIs

auth -> controller

```
/login/
```

core -> controller

```
/
/contact/create
/contact/<con_id>
/organisation/create
/organisation/<org_id>
```

# Folder Structure

```
- app
   |_ auth ...... controller, form helper and model for authentication
   |_ core ...... controller, form helper and model for core functions
   |_ database ...... admin data initialisation
   |_ templates ...... HTML templates for simple webpages
- tests ...... Unit Test files
- config.py ...... DB config for test
- manage.py ...... DB operation
- run.py ...... Run the App from here
```


