set -eux

# Clear artefact folder
cd ..
rm -rf GITEE_TARGET/*

# Copy artefacts
cp -r "$DIST"/* GITEE_TARGET

# Bypass JEKYLL
touch GITEE_TARGET/.nojekyll

# Write INFO.JSON
cat >GITEE_TARGET/info.json <<EOF
{
  "component": "$APP_NAME",
  "version": "$VERSION",
  "environment": "$ENV",
  "instance": "Gitee"
}
EOF

# Push
cd GITEE_TARGET
git add .
git commit -m "Release version $VERSION to $ENV"
git push
