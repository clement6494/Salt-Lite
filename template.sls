admin--create-template:

  qvm.clone:
    - name: admin
    - source: debian-12-xfce
    - prefs:
      - netvm: sys-firewall
