#!/bin/bash                                                                                                                            

date
cd /data/updateFork/
git checkout master

git pull -r sofa-framework master
echo "updating mimesis fork's master branch..."
git push -u mimesis-inria master
echo "Done."

#running mesUpdate.sh                                                                                                                  
echo "merging all branches in mimesis (if any change occured)"
sh mesUpdate.sh
echo "Done."

