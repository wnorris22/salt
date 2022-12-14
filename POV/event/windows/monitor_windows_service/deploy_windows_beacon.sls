##
## POV/event-driven-automation/windows/monitor_windows_service/deploy_windows_beacon.sls
## 
##  This state copies the beacon configuration to the minion, and restarts the salt-minion service
##
##
## C:\ProgramData\Salt Project\Salt\conf\minion.d\beacons.conf
## /etc/salt/minion.d
##

configure_beacon:
  file.managed:
    - name: 'C:\ProgramData\Salt Project\Salt\conf\minion.d\beacons.conf'
    - source: salt://POV/event/windows/monitor_windows_service/files/windows_beacon.conf
    - makedirs: True

restart_salt-minion:
  service.running:
    - name: salt-minion
    - enable: True
    - watch:
      - configure_beacon