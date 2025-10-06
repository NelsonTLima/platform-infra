## HOW TO:

### Dependencies

This project depends on ***terraform*** and a ***python*** virtual environment with ***ansible*** installed. Also, ***vagrant*** for developing and testing provisioning.

1. You can easily find terraform and vagrant installation directives at their websites [terraform.io](terraform.io) and [vagrantup.com](vagrantup.com)

2. Then, make sure having a python virtual environment with ansible on it.

```bash
# Create venv
python3 -m venv .venv

# Activate venv
source .venv/bin/activate

# Install requirements
pip install -r requirements.txt
```

###  Configuration and testing

3. Before terraforming the infrastructure we shall set our credentials and variables by editing these files:

- credentials.auto.tfvars   -> Defines Terraform secret vars for managing AWS and Cloudflare
- playbook.yaml             -> Calls Ansible roles to be executed.
- provision.yaml            -> Defines vars for provisioning with ansible.

4. Then, we can check our terraform plan with.

```bash
terraform plan
```

5. And create an entire VM for testing the configuration.

```bash
vagrant up
```

### Execution

6. Finaly, we can terraform our entire infrastructure.

```bash
terraform apply
```
