# API Gateway Challenge

Here you'll find some information on my experience with the [Contino API
Challenge](https://github.com/contino/tc-apigateway).

## Thank You

Hello and thank you for letting me take the challenge!

Thank you for spending your time marking my solution and reading this :)

## [How To Play](https://www.youtube.com/embed/PVHx47Xyhow?start=0&end=2)

### Makefiles Not War

This solution is directed by a [Makefile](Makefile) which:
1. Sets some variables to a passed in value, or their defaults
1. Runs a [deploy](scripts/deploy) script, with variable values passed in. 

The variables set by the Makefile, which you can override, are listed below

|   Variable Name |                             Description                          | Default Vault |  
|----------------:|:-----------------------------------------------------------------|:--------------|
|          region | AWS Region which in which all resources will be deployed         | us-east-1 
|         profile | AWS CLI profile used to launch CloudFormation stacks             | contino-mikey
|        cli_opts | AWS CLI options as single space-delimited string                 | --profile $(profile) --region $(region)
|        template | Name of the AWS CLI profile used to launch CloudFormation stacks | ../cloudformation/tc_apigateway.file
|      stack_name | Name your stacks to claim your stacks!                           | tc-apigateway-stack-<datetime-stamp>
|    capabilities | Name of AWS Region which in which all resources will be deployed | CAPABILITY_IAM
| subcommand_opts | AWS CLI Subcommand options as single space-delimited string      | --stack-name $(stack_name) --template-file $(template) --capabilities $(capabilities)

### Deploy Stacks Not Soldiers

The deploy script uses the AWS CLI subcommand `cloudformatiopn deploy`to deploy stacks. 

You can run the deploy script without make, but it's important to
note that the deploy script sets no defaults and it's parameters
are simple, to allow flexibility. It's usage is like so: 

`deploy -c '<AWS_CLI_OPTION> ...' -s '<AWS_SUBCOMMAND_PARAMETER> ...'"`

It's important to note that there are no defaults set in this script. 
The table below describes each option and gives examples.

|              Option Name |                             Description             | Example Value |  
|-------------------------:|:----------------------------------------------------|:--------------|
|           AWS_CLI_OPTION | Options as single space-delimited string            | '--profile contino-mikey --region us-east-2'
| AWS_SUBCOMMAND_PARAMETER | Subcommand options as single space-delimited string | '--template-file cloudformation/tc-apigateway.yaml --stack-name cool-stack --capabilities CAPABILITY_IAM'

Thus, running the deplpoy script should look something like this:
`deploy -c '--profile contino-mikey --region us-east-2' -s '--template-file cloudformation/tc-apigateway.yaml --stack-name cool-stack --capabilities CAPABILITY_IAM'`

### Dependencies

Please make sure that you've installed the
[AWS CLI](https://docs.aws.amazon.com/cli/index.html).

You'll also need to have configured the AWS CLI, to specify a profile that
the AWS CLI will use to deploy the CloudFormation stack.

### What To Expect

First, some simple steps to get you going:

1. Clone the repository
1. Open your terminal in the repository
1. Know which AWS profile you want to run this with
1. Run `make profile=<your-aws-profile> deploy`
1. Observe that the stack is creating...

#### Building the Infrastructure

You should see an output similar to the following:

```output
👨🏽‍💻 in tc-apigateway-solution
make profile=<profile-name> deploy
./scripts/deploy -c '--profile <profile-name> --region us-east-2' -s '--stack-name tc-apigateway-stack-20190918203619 --template-file ./cloudformation/tc_apigateway.yaml --capabilities CAPABILITY_IAM'
Deploying stack with: aws --profile <profile-name> --region us-east-2 cloudformation deploy --stack-name tc-apigateway-stack-20190918203619 --template-file ./cloudformation/tc_apigateway.yaml --capabilities CAPABILITY_IAM

Waiting for changeset to be created...
Waiting for stack create/update to complete
Successfully created/updated stack - tc-apigateway-stack-20190918203619
```

Once the command has returned, hopefully you can check the stack resources:

```shell
aws --profile <profile-name> --region us-east-2 \
cloudformation list-stack-resources \
--stack-name tc-apigateway-stack-20190918203619 \
--output table \
--query "StackResourceSummaries[*].{\
 "ResourceStatus": ResourceStatus,\
 "ResourceType": ResourceType,\
 "LogicalResourceId": LogicalResourceId,\
 "PhysicalResourceId":PhysicalResourceId\
}"
```

Which should show:

```output
----------------------------------------------------------------------------------------------------------------
|                                              ListStackResources                                              |
+---------------------+--------------------------------------------------------------------+-------------------+
|  LogicalResourceId  |                        PhysicalResourceId                          |  ResourceStatus   |
+---------------------+--------------------------------------------------------------------+-------------------+
|  APIPermission      |  tc-apigateway-stack-20190918203619-APIPermission-1IUJ0V7RFGXRW    |  CREATE_COMPLETE  |
|  ApiDeployment      |  u7q1sc                                                            |  CREATE_COMPLETE  |
|  ApiKey             |  k1xmryzmj9                                                        |  CREATE_COMPLETE  |
|  ApiMethod          |  tc-ap-ApiMe-BX9S43VYHJY3                                          |  CREATE_COMPLETE  |
|  ApiModel           |  Team                                                              |  CREATE_COMPLETE  |
|  ApiResource        |  ib44xe                                                            |  CREATE_COMPLETE  |
|  ApiRestApi         |  907yi7vcia                                                        |  CREATE_COMPLETE  |
|  ApiUsagePlan       |  biz0vy                                                            |  CREATE_COMPLETE  |
|  ApiUsagePlanKey    |  k1xmryzmj9:biz0vy                                                 |  CREATE_COMPLETE  |
|  DynamoTable        |  Challenge_Mikey                                                   |  CREATE_COMPLETE  |
|  LambdaExecutionRole|  tc-apigateway-stack-2019091820-LambdaExecutionRole-1LWR1CON0NTC0  |  CREATE_COMPLETE  |
|  LambdaFunction     |  tc-apigateway-stack-20190918203619-LambdaFunction-1NUVHV889T7JQ   |  CREATE_COMPLETE  |
+---------------------+--------------------------------------------------------------------+-------------------+
````

#### Making Requests

Now you can POST to the API

```shell
curl -L "https://907yi7vcia.execute-api.us-east-2.amazonaws.com/v1/add_new" \
	-X POST \
	-d '{
    "team_country": "Aussie",
    "team_name": "TeamMikey",
    "team_desc": "good at this sport",
    "team_rating": "10/10"
  }' \
	-H "Content-Type: application/json" \
	-H "x-api-key: $(aws --profile <profile-name> --region us-east-2 apigateway get-api-keys --include-values --query items[*].value --output text)";
```

Note that your API hey is never assigned to a variable in the environment or printed
anywhere (or contained in this repository).

## Tasks

Let's take a look at the tasks and what I managed to achieve

- [x] Team data added/updated in DynamoDB Table via API Gateway POST request
- [x] Add an API Key to restrict client-side access to the the API Gateway
- [ ] Notifications for DB Updates

## Deliverables

-   [x] Share your code with us through your own git repository

-   [x] Make sure that all resources required by your stack are included on the
        deployment process.

-   [x] Include a README with details on how to run your code

-   [x] Consider security on all pieces of your work.
    - Thought about this a lot, I wonder if it shows; however, I'm doubtful
      that it does.  

-   [x] README a section with recommended improvements...

### Roadmap

Some things I'd love to do if I could spend some more time:

-   [ ] Create tests for Lambda code

-   [ ] Separating the Lambda from the CloudFormation template

-   [ ] Splitting the template into 3 components to a CDK app

-   [ ] Creating a CircleCI pipeline

-   [ ] Update API Keys automatically on a regular basis

-   [ ] Using SSM Parameter Store to manage secrets

-   [ ] Using UpdateItem() instead of PutItem()

-   [ ] There are probably many DB optimisations that could be made

-   [ ] Using API to directly update the Table, rather than
        creating a Lambda

-   [ ] Review API's permission to execute the Lambda function from any
        /${Stage}/${Method}/${ApiSpecificResourcePath}. See below:

-   [ ] Locking the SourceARN down in the [APIPermission](https://github.com/mikey-/tc-apigateway-solution/master/blob/cloudformation/tc_apigateway.yaml#L80)
        AWS::Lambda::Permission resource, to include the
        "/${Stage}/${Method}/${ApiSpecificResourcePath}".
        See [Resources Defined by Amazon API Gateway](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonapigateway.html#amazonapigateway-resources-for-iam-policies)
        for more information.

### Other Thoughts

HERE'S WHAT ELSE I THINK:

It'd would be worth looking into the benefits of improving the stylistic 
elements of the challenge's documentation, code and templates.

I probably complained about doing this test a lot, but I really did enjoy the
process and found it to be very rewarding. Arguably the most valuable lessons
I learned through this were:

-   **Assumptions:**
    I unconsciously assumed that _pretty much knew what I had to know about API
    Gateway_; when in fact, I  don't have much of an understanding how modern
    APIs work in general, let alone the particularities of a product made of
    complex systems which can generate modern web APIs.

-   **Makefiles are alright:**
    I kind of thought they were annoying for a bunch of IaC projects.
    I guess I still do but I see their utility a lot more :)  

There's probably a lot more on that I've forgotten about.

It'd be great to have done this with someone, pair programming styles.

#### Oh, one last thing

Did I get the job?!
