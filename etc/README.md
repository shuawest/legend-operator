
# Operator SDK Utility scripts

## Setup GitHub codespaces environment

1. Fork the finos legend-operator repository on github

2. Create a codespace for the repository: Click greed 'Code' button, select Codespaces tab Create a new Codespace

3. Configure your environment

Copy the `.env.tmpl` to `.env` and make sure it is executable, which will be ignored by git 
```
cd /workspaces/finos-operator/etc
cp .env.tmpl .env
chmod a+x .env
```

Edit the .env file. Fill in the empty variables for your environment, and check the derived variables fit your specific environment. 

4. Review build-vars.sh, and update as necessary

5. Initialize the codespaces environment by installing the openshift client and operator-sdk

```
cd /workspaces/finos-operator/etc
. ./codespaces-init.sh
```

