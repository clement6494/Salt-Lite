sys-net-usb:
  qvm.vm:
    - clone:
      - source: sys-net
    - prefs:
      - provides-network: 1
      
sys-net-usb--attach-wifi-device:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option no-strict-reset=true sys-net-usb dom0:00_14.3


sys-net-usb--attach-usb-device-1:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option no-strict-reset=true sys-net-usb dom0:00_0d.0  

sys-net-usb--attach-usb-device-2:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option no-strict-reset=true sys-net-usb dom0:00_0d.2

sys-net-usb--attach-usb-device-3:
  cmd.run:
    - name: sudo qvm-pci attach --persistent --option permissive=true --option no-strict-reset=true sys-net-usb dom0:00_14.0