## HOW TO:

### Dependencies

This project depends on ***terraform*** and a ***python*** virtual environment with ***ansible*** installed. Also, ***vagrant*** for developing and testing provisioning.

1. You can easily find terraform and vagrant installation directives at their websites [terraform.io](terraform.io) and [vagrantup.com](vagrantup.com)

2. Make sure having a python virtual environment with ansible on it.

```bash
# Poject root directory.

# Create venv
python3 -m venv .venv

# Activate venv
source .venv/bin/activate

# Install requirements
pip install -r python.requirements.txt
ansible-galaxy collection install -r ansible.requirements.yml
```

###  Configuration and testing

3. Before terraforming the infrastructure we shall set our credentials and variables by editing these files:

At ./terraform
- credentials.auto.tfvars: defines Terraform secret vars for managing AWS and Cloudflare
- app_domains.yaml: it's a yaml file with project's names and domains.

At ./ansible
- playbook.yaml: Defines wich provision roles will be executed.
- vars.yaml: Defines vars such as hostname, domain, and users to be provisioned.

4. We can check our terraform plan.

```bash
# ./terraform directory
terraform plan
```

5. Also, we can create an entire vm for testing provisioning.

```bash
# ./ansible directory
vagrant up
```

### Execution

6. And finaly terraform our entire infrastructure.

```bash
# ./terraform directory
terraform apply
```
