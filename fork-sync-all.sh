origin=origin
upstream=central

sync() {
  branch=$(git remote show $2 | grep 'HEAD branch' | cut -d' ' -f5)
  echo "Default branch is $branch"

  echo ""
  echo "Fetching all remotes"
  git fetch

  echo ""
  echo "Pulling changes on the $branch"
  git pull $1 $branch --ff-only

  echo ""
  echo "Checking out $branch"
  git checkout $branch

  echo ""
  echo "Pull changes from upstream to forked repository locally"
  git pull $2 $branch --ff-only

  echo ""
  echo "Push the synced commits"
  git push $1 $branch

  echo ""
  echo "Run GC"
  git gc
}

current_directory=$(pwd)

for f in *; do
    if [ -d "$f" ]; then
      echo ""
      echo "WORKING ON $f"
      cd $f
      sync $origin $upstream
      echo "==================================="
      cd $current_directory
    fi
done
