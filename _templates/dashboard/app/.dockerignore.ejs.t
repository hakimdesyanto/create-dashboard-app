---
to: "<%= appDeploy.startsWith('gke') ? `.dockerignore` : null %>"
---
.infra
.dockerignore
.DS_Store
.editorconfig
.env*
.git
.gitignore
.gitmodules
.idea
.vscode
*.log
coverage
Dockerfile
Makefile
README.md