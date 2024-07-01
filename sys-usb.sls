sys-usb--update-qube:
  qvm.present:
   - mem: 500
   - netvm: proxy


sys-usb--detach-usb-devices-1:
  cmd.run:
    - name: sudo qvm-pci detach --persistent --option permissive=true --option no-strict-reset=true sys-usb dom0:00_0d.0 
    
    
sys-usb--detach-usb-device-2:
  cmd.run:
    - name: sudo qvm-pci detach --persistent --option permissive=true --option no-strict-reset=true sys-usb dom0:00_0d.2
    
    
sys-usb--detach-usb-devices-3:
  cmd.run:
    - name: sudo qvm-pci detach --persistent --option permissive=true --option no-strict-reset=true sys-usb dom0:00_14.0