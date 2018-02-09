#Run the below lines, if you would like to deletes all the repositories from Github and AWS-CodeCommit.

GIT_ORG="ORG"
echo "Starts for deleting repository"   
	cat repository.txt | while read next                       
	echo "Repository Name $next"  
    do
        #You have to configure aws-cli(access_key, secret_key) on your machine
        aws codecommit delete-repository --repository-name $next --region us-east-1
        curl -X DELETE -u $GIT_USER:$GIT_PASSWORD https://api.github.com/repos/$GIT_ORG/$next
     done
echo "Removed all the repositories from CodeCommit and AWS-CodeCommit"
