# Ansible Role: Bloodhound-CE (Ludus)

An Ansible Role that installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound) on a debian based system.

- Install Bloodhound-CE version `8.0.0`
- Uses `bloodhoundpassword` as default password. Can be changed using `role_vars`.
- Checks if {{ ludus_bloodhound_ce_install_path }}/docker-compose.yml exists
- If not, it installs vanilla bloodhound-ce (via docker-compose)
- Outputs the admin password in bloodhound_ce_install_path (default: `/opt/bloodhound`)

## Requirements

Debian based OS

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    # Path where docker-compose.yml and admin creds are placed
    ludus_bloodhound_ce_install_path: /opt/bloodhound

    # Expose bloodhound web UI to 0.0.0.0:8080 if set to false (default: false)
    ludus_bloodhound_listen_only_localhost: false

    # The port bloodhound CE listens on
    ludus_bloodhound_port: "8080"

    # The default admin password for bloodhound (default: bloodhoundpassword)
    ludus_bloodhound_admin_password: "bloodhoundpassword"

    # Other admin details defaults
    ludus_bloodhound_admin_principal_name: "admin"
    ludus_bloodhound_admin_email_address: "admin@ludus.domain"
    ludus_bloodhound_admin_first_name: "Bloodhound"
    ludus_bloodhound_admin_last_name: "Admin"

    # Bloodhound docker compose tag (version)
    ludus_bloodhound_tag: "8.0.0"

## Dependencies

[geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)

## Example Ludus Range Config

```yaml
ludus:
  - vm_name: "{{ range_id }}-docker-services"
    hostname: "{{ range_id }}-services"
    template: debian-12-x64-server-template
    vlan: 99
    ip_last_octet: 2
    ram_gb: 8
    cpus: 2
    linux: true
    testing:
      snapshot: false
      block_internet: false
    roles:
      - badsectorlabs.ludus_bloodhound_ce
    role_vars:
      ludus_bloodhound_port: "80"
      ludus_bloodhound_admin_password: "bloodhoundpassword123"
```

## Ludus setup

```
# Add the role to the ludus user ansible role inventory
ludus ansible roles add badsectorlabs.ludus_bloodhound_ce

# Get the current range config
ludus range config get > config.yml

# Edit config to add the role to the VMs you wish to install bloodhound on and define your desired ludus_bloodhound_ce vars
ludus range config set -f config.yml
ludus range deploy
```

## Trobleshooting

To force the role to re-run (fresh Bloodhound instance), SSH into the VM, stop the docker container and remove the ludus_bloodhound_ce_install_path folder (default to `/opt/bloodhound`)

```
cd /opt/bloodhound
docker compose down
cd ..
# assuming there are no other docker volumes used by other containers
xargs -r docker volume rm
rm -rf /opt/bloodhound
```

This removes the existing bloodhound related docker containers and volumes.

## License

Apache 2.0

This Ludus role installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound). Credits to the SpecterOps team for the amazing contributions to the industry.

## Author Information

This role was created in 2024 by [Bad Sector Labs](https://badsectorlabs.com/), for [Ludus](https://ludus.cloud/).
