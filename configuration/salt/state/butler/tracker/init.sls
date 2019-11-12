butler-tracker-clone:
  git.latest:
    - rev: master
    - force_reset: True
    - name: https://github.com/EMBL-EBI-EMBASSY/butler_cluster.git
    - target: /opt/butler
    - submodules: True
    
install_butler_tracker:
  cmd.run:
    - name: pip install -e .
    - cwd: /opt/butler/track/

/usr/bin/butler:
  file.symlink:
    - target: /opt/butler/track/tracker/bin/butler
    - user: root
    - group: root
    - mode: 755
    - force: True
