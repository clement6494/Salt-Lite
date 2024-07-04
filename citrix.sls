{% if grains['id'] == 'dom0' %}

citrix--create-qube:
  qvm.vm:
    - name: citrix
    - present:
      - template: windows
      - label: blue
      - flags:
        - disposable
