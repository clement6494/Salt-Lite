sys-net--detach-wifi-device:
  cmd.run:
    - name: sudo qvm-pci detach --persistent --option permissive=true sys-net dom0:00_14.3