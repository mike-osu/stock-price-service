# zip dependencies from virtualenv and source files
rm src/yahoo-lambda.zip
cd env/lib/python3.6/site-packages/
zip -r9 ../../../../src/yahoo-lambda.zip *
cd ../../../../src/
zip -g yahoo-lambda.zip lambda_function.py
cd ..

# package cloudformation
aws cloudformation package --s3-bucket bucket-name-for-package \
    --template-file template.yaml \
    --output-template-file gen/template-generated.yaml

# deploy cloudformation
aws cloudformation deploy \
    --template-file gen/template-generated.yaml \
    --stack-name YahooServiceLambdaStack \
    --capabilities CAPABILITY_IAM

# delete stack
aws cloudformation delete-stack --stack-name YahooServiceLambdaStack