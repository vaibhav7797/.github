# In a new repo:
git init
# add files above
pipx install pre-commit commitizen || pip install --user pre-commit commitizen
pre-commit install --install-hooks
pre-commit install --hook-type commit-msg
git add .
git commit -m "chore: repo guardrails (devcontainer, pre-commit, CI, policies)"
git branch -M main
git remote add origin <your-repo>
git push -u origin main
