set -eux

# Checkout to gh-pages branch
cd GITHUB_TARGET/
{ git checkout gh-pages; } || { git checkout -b gh-pages; }

# Clear folder
cd ..
rm -rf GITHUB_TARGET/*

# Copy artefacts
cp -r "$DIST"/* GITHUB_TARGET

# Bypass JEKYLL
touch GITHUB_TARGET/.nojekyll

# Write INFO.JSON
cat >GITHUB_TARGET/info.json <<EOF
{
  "component": "$APP_NAME",
  "version": "$VERSION",
  "environment": "$ENV",
  "instance": "GitHub"
}
EOF

# Push
cd GITHUB_TARGET
git add .
git commit -m "Release version $VERSION to $ENV"
git push -u origin gh-pages
