base:
  '*':
    - selinux
    - dnsmasq
    - ntp
  'G@roles:consul-ui':
    - consul.ui
  'G@roles:worker':
    - git
    - gcc
    - celery
    - airflow
    - airflow.worker
    - butler.tracker
  'G@roles:tracker':
    - git
    - gcc
    - run-tracking-db.set_db_url
    - celery
    - airflow
    - airflow.init-db
    - airflow.server
    - jsonmerge
    - butler.tracker
    - hostfile
  'G@roles:db-server':
    - postgres
    - run-tracking-db
    - run-tracking-db.create_tables
    - airflow.airflow-db
  'G@roles:job-queue':
    - rabbitmq
  'G@roles:butler-web':
    - git
    - nginx
    - butler.web
  'G@roles:salt-master':
    - salt.api 
