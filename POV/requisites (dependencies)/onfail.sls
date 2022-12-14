# Onfail allows actions to be taken as a response to a failure in another state
# Only run backup_mount if primary_mount fails
# think of it as a Contingency Plan

primary_mount:
  mount.mounted:
    - name /mnt/share
    - device: 10.0.0.45:/share
    - fstype: nfs

backup_mount:
  mount.mounted:
    - name: /mnt/share
    - device: 192.168.40.34:/share
    - fstype: nfs
    - onfail:
      - mount: primary_mount

# another example

http_service:
  service.running:
    - name: http

repot_failures:
  module.run:
    - name: slack_notify.call_hook
    - kwargs:
        message: Apache failed to start
    - onfail:
      - serfice: httpd_service