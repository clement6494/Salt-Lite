{% if grains['id'] == 'dom0' %}

citrix--create-qube:
  qvm.vm:
    - name: citrix
    - present:
      - template: debian-11
      - label: blue
      - flags:
        - disposable


{% elif grains['id'] == 'debian-11' %}

citrix-export-script:
  file.recurse:
    - name: ~/Documents/install-citrix-2203.sh
    - source: salt://script/install-citrix-2203.sh
    - clean: False

mount-citrix-script-in-template:
  cmd.run:
    - name: sudo chmod +x ~/Documents/install-citrix-2203.sh


install-citrix-in-template:
  cmd.run:
    - name: sudo ~/Documents/install-citrix-2203.sh

{% endif %}