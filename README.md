# Ansible Role: letsencrypt

Create certificates and get them signed by LetsEncrypt.

[Changelog](CHANGELOG.md)

# Requirements

None.

# Role Variables

Available variables are listed below, along with default values from `defaults/main.yml`

---

```yaml
letsencrypt_domains: []
```
List of domains to create a certificate for.
In turn takes **at least** the following arguments for every certificate:
* `fqdn`: domainname for the certificate
* `provider`: provider for the verification challenge method
* `challenge`: method of the verification challenge - optional - defaults to dns-01

A certificate validated via the dns-01 method on aws route53 would look like this:

```yaml
letsencrypt_domains:
  - fqdn: example.com
    provider: route53
```

the following options are available which overwrite the global defaults per Domain:
* `staging_api`
  Default: `False`
  Get a certificate from the staging api. Useful for development.

* `days_left_before_renew`
  (Global) Default: 21
  Renews the certificate if it is valid less than the specified time in days.

---

```yaml
letsencrypt_acme_version: 2
```
The ACME version of the endpoint. Only tested with `2`.

---

```yaml
letsencrypt_production_api: https://acme-v02.api.letsencrypt.org/directory
```
URL of the acme production api. Using Letsencrypt by default.

---
```yaml
letsencrypt_staging_api: https://acme-staging-v02.api.letsencrypt.org/directory
```
URL of the acme staging api. Using Letsencrypt by default.

---
```yaml
letsencrypt_dir: /etc/letsencrypt
```
Basedir for configuration and certificates

---
```yaml
letsencrypt_days_left_before_renew: 21
```

Global default for renewal. Renews cert if it is valid less days than specified.

---

# Dependencies

None.

# Example Playbook

```yaml
- hosts: primary-loadbalaner
  vars:
    letsencrypt_domains:
      - fqdn: foo.bar
        challenge: dns-01
        provider: hcloud
        dns_zone: foo.bar
  roles:
    - letsencrypt
```
