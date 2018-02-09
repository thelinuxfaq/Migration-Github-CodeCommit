GITHUB_ORG="ORG"

curl --silent -u USERNAME:PASSWORD https://api.github.com/orgs/$GITHUB_ORG/repos?per_page=100 -q | grep "\"name\"" | awk -F': "' '{print $2}' | sed -e 's/",//g' >> ~/codecommit/repository.txt
mkdir ~/codecommit && cd ~/codecommit
echo "start"   
cat repository.txt | while read next                       
echo "Repository Name $next"  

do

  echo $next
  aws codecommit create-repository --repository-name $next --region us-east-1
  git clone --mirror git@github.com:$GITHUB_ORG/$next.git
  cd ~/codecommit/$next.git

  git push https://USERNAME:PASSWORD@git-codecommit.us-east-1.amazonaws.com/v1/repos/$next --all
  git push https://USERNAME:PASSWORD@git-codecommit.us-east-1.amazonaws.com/v1/repos/$next --tags
    sleep 10

  aws codecommit update-default-branch --repository-name $next --default-branch-name master --region us-east-1

done
