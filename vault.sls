#update vault qube
vault:
  qvm.vm:
    - present:
      - template: debian-12-xfce
      - label: black
    - prefs:
      - label: black
      - netvm: none
# Ensuring that no default_dispvm is set prevents a security warning in the Qube Manager (as well as accidental network access via disposable VMs).
      - default_dispvm:
      - autostart: true
    - features:
      - set:
        - menu-items: org.keepassxc.KeePassXC.desktop xfce4-terminal.desktop thunar.desktop