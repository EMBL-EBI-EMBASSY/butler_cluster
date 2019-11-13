base:
  '*':
    - selinux
    - dnsmasq
    - ntp
  'G@roles:consul-ui':
    - consul.ui
  'G@roles:worker':
    - git
    - celery
    - airflow
    - airflow.worker
    - butler.tracker
  'G@roles:tracker':
    - git
    - run-tracking-db.set_db_url
    - celery
    - airflow
    - airflow.init-db
    - airflow.patch-airflow-url-prefix
    - airflow.server
    - jsonmerge
    - butler.tracker
    - hostfile
  'G@roles:db-server':
    - postgres
    - run-tracking-db
    - run-tracking-db.create_tables
    - grafana.createdb
    - airflow.airflow-db
  'G@roles:job-queue':
    - rabbitmq
  'G@roles:R':
    - R
  'G@roles:butler-web':
    - git
    - nginx
    - butler.web
  'G@roles:salt-master':
    - salt.api 
