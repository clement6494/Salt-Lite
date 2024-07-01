sys-usb--update-qube:
  qvm.present:
   - mem: 500
   - netvm: proxy


sys-usb--detach-usb-devices:
  cmd.run:
    - name: sudo qvm-pci detach --persistent --option permissive=true sys-usb dom0:00_0d.0 dom0:00_0d.2 dom0:00_14.0