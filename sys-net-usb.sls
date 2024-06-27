sys-net-usb:
  qvm.vm:
    - clone:
      - source: sys-net
    - prefs:
      - provides-network: 1
      
