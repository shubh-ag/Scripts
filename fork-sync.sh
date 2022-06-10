origin=origin
upstream=central

branch=$(git remote show $upstream | grep 'HEAD branch' | cut -d' ' -f5)
echo "Default branch is $branch"

echo ""
echo "Fetching all remotes"
git fetch

echo ""
echo "Pulling changes on the $branch"
git pull $origin $branch --ff-only

echo ""
echo "Checking out $branch"
git checkout $branch

echo ""
echo "Pull changes from upstream to forked repository locally"
git pull $upstream $branch --ff-only

echo ""
echo "Push the synced commits"
git push $origin $branch

echo ""
echo "Run GC"
git gc
