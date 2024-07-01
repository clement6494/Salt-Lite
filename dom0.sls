citrix--add-mouse-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/qubes.inputMouse
    - source: salt://policy/qubes.inputMouse

citrix--add-usb-policy:
  file.managed:
    - name: /etc/qubes-rpc/policy/qubes.USB
    - source: salt://policy/qubes.USB
    
