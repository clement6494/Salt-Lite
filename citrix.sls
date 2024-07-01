{% if grains['id'] == 'dom0' %}

citrix--create-qube:
  qvm.vm:
    - name: citrix
    - present:
      - template: admin
      - label: blue
    - features:
      - set:
        - menu-items: firefox-esr.desktop selfservice.desktop thunar.desktop

{% elif grains['id'] == 'admin' %}

citrix--add-firewall:
  file.managed:
    - name: /var/lib/qubes/appvms/citrix/firewall.xml
    - source: salt://citrix/firewall.xml

citrix--install-citrix:
  cmd:
    - run: salt://citrix/script.sh

{% endif %}