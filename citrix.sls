{% if grains['id'] == 'dom0' %}

citrix--create-qube:
  qvm.vm:
    - name: citrix
    - present:
      - template: debian-11-minimal
      - label: blue
    - features:
      - set:
        - menu-items: firefox-esr.desktop selfservice.desktop thunar.desktop

{% elif grains['id'] == 'citrix' %}

citrix--add-firewall:
  file.managed:
    - name: /var/lib/qubes/appvms/citrix/firewall.xml
    - source: salt://citrix/firewall.xml

citrix--install-citrix:
  cmd:
    - run: salt://citrix/script.sh

{% endif %}