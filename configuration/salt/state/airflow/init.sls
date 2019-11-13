python_pip_setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True

prereqs_pip:
  pkg.latest:
    - pkgs: 
      - gcc
      - python3-devel
      - python36-psycopg2

install_numpy:
  pip.installed: 
    - name: numpy
    - upgrade: True

pip_pkg:
  pkg.installed:
    - python3-pip

virtualenv_pkg:
  pkg.installed:
    - python36-virtualenv    

virtualenv_airflow:
  virtualenv.managed
    - name: /opt/venv/airflow
    - system_stie_packages: False
    - require:
      - pkg: virtualenv_pkg 
  
install_airflow:
  pip.installed: 
    - name: apache-airflow == 1.10.6
    - bin_env: /usr/pip3
    - ignore-installed: True
    - env_vars:
         SLUGIFY_USES_TEXT_UNIDECODE: u'yes'
    - upgrade: False
    - require:
      - virtualenv: virtualenv_airflow
      - pkg: pip_pkg
    
    
install_statsd:
  pip.installed: 
    - name: statsd
    - upgrade: True

airflow_group:
  group.present:
    - name: airflow

airflow_user:
  user.present:
    - name: airflow
    - home: /home/airflow
    - gid_from_name: True
    - empty_password: True
    
{{ pillar['airflow_home'] }}:
  file.directory:    
    - user: airflow
    - group: airflow
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True 

/var/log/airflow:
  file.directory:    
    - user: airflow
    - group: airflow
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True 

{{ pillar['airflow_config'] }}:
  file.managed:
    - source: salt://airflow/config/airflow.cfg
    - user: airflow
    - group: airflow
    - mode: 600
    - makedirs: True
    - template: jinja
    
/etc/sysconfig/airflow:
  file.managed:
    - source: salt://airflow/config/airflow
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
    - template: jinja
        
/etc/profile.d/set_airflow_env.sh:
  file.managed:
    - source: salt://airflow/config/set_airflow_env.sh
    - user: root
    - group: root
    - mode: 700
    - makedirs: True
    - template: jinja
