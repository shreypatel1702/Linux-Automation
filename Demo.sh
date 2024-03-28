cd ~/repositoryname &&
wget -O check-assign2-script.sh https://zonzorp.github.io/COMP2137/check-assign2-script.sh &&
chmod +x ./check-assign2-script.sh &&
./check-assign2-script.sh https://github.com/yourgithubusername/yourreponame/assignment2.sh 2>&1 >assignment2-checked.txt &&
git add -A &&
git commit -m "Assignmment2 checked" &&
git push origin main
