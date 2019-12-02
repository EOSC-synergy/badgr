# Badgr Dockerfiles

## Badgr Server

How to launch Badgr Server:

```sh
docker run -d -p 8000:8000 eoscsynergy/badgr-server
```

To modify the configuration file add a volume with the file:

```sh
-v "<local_path>/settings_local.py:/badgr/code/apps/mainsite/settings_local.py"
```

By default it uses an sqlite3 database, to enable persistence add a volume to store it:

```sh
-v "<local_path>/local.sqlite3:/badgr/code/local.sqlite3"
```

In the default sqlite database we have included a basic set of configuration steps:

* Superuser:
  * User: admin
  * Passwd:  badgrpass

But it can but also created inside the docker container using the command:

```sh
/badgr/code/manage.py createsuperuser
```

### Badgr App Configuration

A Badgr App has been added in the DB. It is only needed to change the hostname to point the new UI server. See all the steps at:

https://github.com/concentricsky/badgr-server#badgr-app-configuration

#### Additional Configuration

Oauth application has been added as described here:

https://github.com/concentricsky/badgr-server#additional-configuration

In case of using an external database (changing settings_local.py options) use this command to generate database tables:

```sh
/badgr/code/manage.py migrate
```

Then you can access the management endpoint, using the credentials of the previously created superuser:

http://servername:8000/staff/

## Badgr UI

How to launch Badgr UI::

```sh
docker run --name badgrui -p 80:80 -e BADGRSERVER="http://badgrserve:8000" -d eoscsynergy/badgr-ui
```

In this case only the env variable BADGRSERVER is needed to point to the URL of the Badgr server launched in the previous step.

Then you can access the UI endpoint:

http://servername/

You can login using next credentials:

* Usuario: admin@admin.com
* passwd:  badgrpass

You can also register a new user. But it need the configuration of the email support in the Badgr server. If not, the superuser can activate it using the server management interface.
