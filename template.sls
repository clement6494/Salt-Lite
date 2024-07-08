admin--create-template:
  qvm.clone:
    - name: admin
    - source: debian-12-xfce
    - prefs:
      - netvm: sys-firewall


debian_11:
  cmd.run:
    - name: qvm-template install debian_11
