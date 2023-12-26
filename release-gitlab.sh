set -eux

# Clear artefact folder
cd GITLAB_TARGET/
rm -rf public
mkdir public
cd ..

# Copy artefacts
cp -r "$DIST"/* GITLAB_TARGET/public/
cd GITLAB_TARGET/

# Write INFO.JSON
cat >public/info.json <<EOF
{
  "component": "$APP_NAME",
  "version": "$VERSION",
  "environment": "PRD",
  "instance": "GitLab"
}
EOF

# Write .gitlab-ci.yml
cat >.gitlab-ci.yml <<EOF
pages:
  stage: deploy
  script:
    - echo "Do nothing"
  artifacts:
    paths:
      - public
  only:
    - main
EOF

# Push
git add .
git commit -m "Release version $VERSION to GitLab"
git push
