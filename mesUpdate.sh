#!/bin/sh

## place this file inside the sofa repository on the CI

git fetch

# ALL SOFA BRANCHES
git branch -r | grep sofa-framework | sed  's/sofa-framework/mimesis-inria/' | tee sofa_branches.txt > /dev/null

# ALL MIMESIS BRANCHES
git branch -r | grep mimesis-inria | tee mimesis_branches.txt > /dev/null

#ALL MES BRANCHES ONLY
grep -vxFf sofa_branches.txt mimesis_branches.txt | tee mimesis_only.txt > /dev/null

#WHITELISTED BRANCHES TO MERGE
grep -vxFf blacklist_branches.txt mimesis_only.txt | tee whitelist.txt > /dev/null

git checkout mimesis

echo "list of branches to merge:"
cat whitelist.txt

# merging all the team's branches in mimesis
while read branch
do
    echo "merging $branch..."
    git merge $branch
done < whitelist.txt

# merge master in mimesis
git merge master

# push to the remote
git push -u mimesis-inria mimesis

# get back on master (important for other scripts assuming they're on master...)
git checkout master

# removing temp files...
rm -f whitelist.txt mimesis_only.txt mimesis_branches.txt sofa_branches.txt
