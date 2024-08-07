#create base for windows 10 vm
windows:
  qvm.vm:
    - present:
      - label: orange
      - mem: 8000
      - maxmem: 12000
      - qmemman: 1
      - qrexec_timeout: 7800
      - tags: work
      - stubdom
    - flags:
      - HVM
      - standalone
    - prefs:
      - netvm: sys-firewall-wifi
# Ensuring that no default_dispvm is set prevents a security warning in the Qube Manager (as well as accidental network access via disposable VMs).
      - autostart: true
