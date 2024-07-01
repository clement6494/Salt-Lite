#create base for windows 10 vm
windows:
  qvm.vm:
    - present:
      - template: none
      - label: orange
      - mem: 8000
      - maxmem: 12000
      - qmemman: 1
      - qrexec_timeout: 7800
      -stubdom
    - prefs:
      - label: orange
      - netvm: sys-firewall
# Ensuring that no default_dispvm is set prevents a security warning in the Qube Manager (as well as accidental network access via disposable VMs).
      - standalone:
      - autostart: true
