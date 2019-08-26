# API Gateway Challenge Marking
---

**Challenge Objective**
The main objectives of this challenge is to evaluate the following items:
* Troubleshooting (fix code errors)
* Infrastructure as Code (CF or rewrite in terraform/sam)
* Security(least privilege and api authorization)
* Coding(python or free to use other lambda-compatible language)
* Documentation(problem description, solution and recommendations)
* Automation(Makefile, CI/CD, bash scripting)
* Code quality(unit tests, lint)
* Learning(some requirements will need some research, by not being usual things)

**Issues causing the stack to not work properly**

1. Issue #1: The database name on the lambda function is wrong.
2. Issue #2: IAM role does not have the necessary permissions to write to the dynamodb table.

**Improvements requested**

1. Improvement #1: Add a new field(sport type) in the request and make sure the value is inserted on the table
2. Improvement #2: Add an trigger to the dynamo table to send a message to a sns topic on every change on the table contents
3. Improvement #3: Include an authentication method for the API request

**Other requests**

1. Request #1: Repository publicly available
2. Request #2: README with proper documentation, changes made and proposed improvements

**What will be evaluated**

* Issue #1
  - Ways of fixing:
    - Change the name on the code (hard coded)
    - Add the mapping for team_type to the model and mapping in API Gateway
    - Use of parameter to the database name(dynamic)
    - CF Parameter and use Parameter on lambda code
    - Send the dbaname on the http request
    - Inject the name of the database as environment variable in the lambda
      - Via ARN lookup
      - In the lambda use the environment variable
  - Objective: Check concerns about having hard coded things, which would impact re-usability/maintenance.
* Issue #2
  - Ways of fixing:
    - Use least privilege for the required actions
    - Use a wildcard for the permission
    - Objective: Check concerns about security and the usage of least privilege principles

* Improvement #1
  - Ways of doing:
    - Include the new field on the required cf resources(api method, api model) and in the code(table itemcreate)
  - Objective: Validate code modification competency
* Improvement #2
  - Ways of doing:
    - Include a dynamo stream, a new lambda function and the resources around it and a new sns topic.
  - Objective: Validade the capabilities around the items below:
  - Adding new resources to the CF
  - least privilege principle
    - coding capabilities.
  - Most of this can be gathered from internet, so god to know about researching for solutions
* Improvement #3
  - Ways of doing:
  - Adding a header key-value to the request with an expected value
  - Implement basic auth
    - Add IAM authorization in API Gateway
    - Using cognito with user/pass authentication
  - Objectives: Validate the knowledge around api authentication

* Request #1
  - Ways of doing:
    - Make the git repo public
    - Objective: Validate the ability around using git
* Request #2
  - Ways of doing:
    - creating a README.md file in the repo root folder and have the changes documented.
  - Objective: Validate the documentation capabilities and writing communication of code/work done

* Other possible improvements that can be done or recommended
  - Remove the code from the CF template
  - Move everything to Terraform or use SAM
  - Include tests for the codes
  - Include error handling for the codes
  - Create scripts or a Makefile to be used in a CI/CD pipeline
  - Create a CI/CD pipeline publicly available
  - Dockerize the tests
  - Dockerize the deployment process
  - Add SNS resources with broken components and missing event source so that the candidate can get back with results quicker.

**Evaluation**

* General
  - The instructions described on the README file is working and the original app works successfully
  - Value 1.0
* Issue 1
  - DB name issue is fixed
    - Value 1.0
  - DB name is now dynamic instead of hardcoded
    - Value 0.5
* Issue 2
  - Lambda Execution Role have the required permissions
    - Value 1.0
  - The permissions are using least privilege principle
    - Value 0.5
* Improvement 1
  - The new field is being added to the database
  - Value 0.5
* Improvement 2
  - A message is being delivered to SNS on every table update
    - Value 1.0
  - It’s using least privilege principles for the policies in use
    - Value 0.5
* Improvement 3
  - The API does not accept the request without a token
    - Value 1.0
* The authentication process is secure(must have 2 out of 3):
  - Dynamic
  - User/pass
  - Keys not available on the repo
  - Value 0.5
* Request 1
  - Repo is public
    - Value 0.2
* Request 2
  - Proper README(must have 2 out of 3):
  - Brief description with introduction and requirements
  - Clear steps to reproduce deploy and execution
  - Future recommended improvements
    - Value 0.5
* Extras
  - Move the solution to SAM
    - Value 1.0
  - Architecture Diagram added to the repo
    - Value 0.2
  - Makefile created with steps automated
    - Value 0.2
  - CI/CD pipeline created
    - Value 0.2
  - Tests and linting included for both app code and IaC code
    - Value 0.2
  - Externalize lambda code from CF
    - Value 0.2
  - Improve lambda code(function and error handling)
    - Value 0.2
  - Dockerized tests
    - Value 0.2
  - Dockerized deployment
    - Value 0.2
  - Webhook from repo to pipeline
    - Value 0.2

