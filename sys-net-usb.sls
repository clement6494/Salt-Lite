sys-net-usb:
  qvm.vm:
    - clone:
      - source: sys-net
    - prefs:
      - provides-network: 1
      
sys-net-usb--attach-wifi-device:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option nostrict-reset=true sys-net-usb dom0:00_14.3


sys-net-usb--attach-usb-devices:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option nostrict-reset=true sys-net-usb dom0:00_0d.0 dom0:00_0d.2 dom0:00_14.0