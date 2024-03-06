# Ansible Role: Bloodhound-CE (Ludus)

An Ansible Role that installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound) on a debian system.

- Checks if this role was previously ran
- If the role was not ran, it installs vanilla bloodhound-ce (via docker-compose)
- Outputs the admin password in bloodhound_ce_install_path (default: `/opt/bloodhound`)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    # Path where docker-compose.yml and admin creds are placed
    ludus_bh_ce_install_path: /opt/bloodhound
    # Expose bloodhound web UI to 0.0.0.0:8080 if set to true (default: false)
    ludus_bh_localhost: true

## Dependencies

None.

## Example Ludus Range Config

```yaml
ludus:
  - vm_name: "{{ range_id }}-Docker-Services"
    hostname: "{{ range_id }}-Services"
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
      - badsectorlabs.ludus_bloodhound-ce # to install from ansible galaxy
```

To use this role as shown in the example above:

```
# Clone the repo
git clone https://github.com/badsectorlabs/ludus_bloodhound-ce

# Add repo to your local inventory
ludus ansible role add -d ludus_bloodhound-ce

```

## License

GPLv3

Role installs [Bloodhound-CE](https://github.com/SpecterOps/BloodHound). Credits to the SpecterOps team for the amazing contributions to the industry.

## Author Information

This role was created in 2024 by [Bad Sector Labs](https://badsectorlabs.com/), for [Ludus](https://ludus.cloud/).
