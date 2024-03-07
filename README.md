# Ansible Role: Bloodhound-CE (Ludus)

An Ansible Role that installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound) on a debian based system.

- Checks if {{ ludus_bloodhound_ce_install_path }}/docker-compose.yml exists
- If not, it installs vanilla bloodhound-ce (via docker-compose)
- Outputs the admin password in bloodhound_ce_install_path (default: `/opt/bloodhound`)

To force the role to re-run, stop the docker container and remove the ludus_bloodhound_ce_install_path folder

```
cd /opt/bloodhound
docker compose down
cd ..
rm -rf /opt/bloodhound
```

## Requirements

Debian based OS

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    # Path where docker-compose.yml and admin creds are placed
    ludus_bloodhound_ce_install_path: /opt/bloodhound
    # Expose bloodhound web UI to 0.0.0.0:8080 if set to false (default: true)
    ludus_bloodhound_listen_only_localhost: true
    # The port bloodhound CE listens on
    ludus_bloodhound_port: "8080"
    # The default admin password for bloodhound (default: generate a random password)
    ludus_bloodhound_admin_password:
    # Other admin details defaults
    ludus_bloodhound_admin_principal_name: 'admin'
    ludus_bloodhound_admin_email_address: 'email@bloodhound.ludus'
    ludus_bloodhound_admin_first_name: 'Bloodhound'
    ludus_bloodhound_admin_last_name: 'Admin'

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
      ludus_bloodhound_listen_only_localhost: false
```

## Ludus setup

```
ludus ansible roles add badsectorlabs.ludus_bloodhound_ce
ludus range config get > config.yml
# Edit config to add the role to the VMs you wish to install bloodhound on and define your desired ludus_bloodhound_ce vars
ludus range config set -f config.yml
ludus range deploy -t user-defined-roles
```

## License

Apache 2.0

Role installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound). Credits to the SpecterOps team for the amazing contributions to the industry.

## Author Information

This role was created in 2024 by [Bad Sector Labs](https://badsectorlabs.com/), for [Ludus](https://ludus.cloud/).
