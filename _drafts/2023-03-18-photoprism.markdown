---
layout: post
title:  "PhotoPrism App"
date:   2023-03-18 20:00:10 +0200
categories: [Photos, Management]
tags: [photos, indexing, tag, docker, mariadb]

---
# PhotoPrism App

= Photo-Prism to index ma local images

I'll try out [Photo-Prism App](https://docs.photoprism.app/getting-started/docker-compose/#__tabbed_1_1) to see if it can assist me in managing my photos.
Let's see how easy it is and how far we can get. Today.


1. Download the wget [docker-compose.yml](https://dl.photoprism.app/docker/docker-compose.yml)  

```yaml
$> wget https://dl.photoprism.app/docker/docker-compose.yml
```

2. Inspect docker-compose.yml

```shell
$> docker compose config
```

```yaml
name: photoprism
services:
  mariadb:
    command:
    - mysqld
    - --innodb-buffer-pool-size=512M
    - --transaction-isolation=READ-COMMITTED
    - --character-set-server=utf8mb4
    - --collation-server=utf8mb4_unicode_ci
    - --max-connections=512
    - --innodb-rollback-on-timeout=OFF
    - --innodb-lock-wait-timeout=120
    environment:
      MARIADB_AUTO_UPGRADE: "1"
      MARIADB_DATABASE: photoprism
      MARIADB_INITDB_SKIP_TZINFO: "1"
      MARIADB_PASSWORD: insecure
      MARIADB_ROOT_PASSWORD: insecure
      MARIADB_USER: photoprism
    image: mariadb:10.10
    networks:
      default: null
    restart: unless-stopped
    security_opt:
    - seccomp:unconfined
    - apparmor:unconfined
    volumes:
    - type: bind
      source: /Users/volker/Dev/volker/photoprism/database
      target: /var/lib/mysql
      bind:
        create_host_path: true
  photoprism:
    depends_on:
      mariadb:
        condition: service_started
    environment:
      PHOTOPRISM_ADMIN_PASSWORD: insecure
      PHOTOPRISM_ADMIN_USER: admin
      PHOTOPRISM_AUTH_MODE: password
      PHOTOPRISM_DATABASE_DRIVER: mysql
      PHOTOPRISM_DATABASE_NAME: photoprism
      PHOTOPRISM_DATABASE_PASSWORD: insecure
      PHOTOPRISM_DATABASE_SERVER: mariadb:3306
      PHOTOPRISM_DATABASE_USER: photoprism
      PHOTOPRISM_DETECT_NSFW: "false"
      PHOTOPRISM_DISABLE_CHOWN: "false"
      PHOTOPRISM_DISABLE_CLASSIFICATION: "false"
      PHOTOPRISM_DISABLE_FACES: "false"
      PHOTOPRISM_DISABLE_RAW: "false"
      PHOTOPRISM_DISABLE_SETTINGS: "false"
      PHOTOPRISM_DISABLE_TENSORFLOW: "false"
      PHOTOPRISM_DISABLE_WEBDAV: "false"
      PHOTOPRISM_EXPERIMENTAL: "false"
      PHOTOPRISM_HTTP_COMPRESSION: gzip
      PHOTOPRISM_JPEG_QUALITY: "85"
      PHOTOPRISM_LOG_LEVEL: info
      PHOTOPRISM_ORIGINALS_LIMIT: "5000"
      PHOTOPRISM_RAW_PRESETS: "false"
      PHOTOPRISM_READONLY: "false"
      PHOTOPRISM_SITE_AUTHOR: ""
      PHOTOPRISM_SITE_CAPTION: AI-Powered Photos App
      PHOTOPRISM_SITE_DESCRIPTION: ""
      PHOTOPRISM_SITE_URL: http://photoprism.me:2342/
      PHOTOPRISM_UPLOAD_NSFW: "true"
    image: photoprism/photoprism:latest
    networks:
      default: null
    ports:
    - mode: ingress
      target: 2342
      published: "2342"
      protocol: tcp
    security_opt:
    - seccomp:unconfined
    - apparmor:unconfined
    volumes:
    - type: bind
      source: /Users/volker/Pictures
      target: /photoprism/originals
      bind:
        create_host_path: true
    - type: bind
      source: /Users/volker/Dev/volker/photoprism/storage
      target: /photoprism/storage
      bind:
        create_host_path: true
    working_dir: /photoprism
networks:
  default:
    name: photoprism_default
```

3. Nothing unusual so far - lets give it a try

```shell
$> docker compose up -d && docker compose logs -f
❯ docker compose up -d && docker compose logs -f
[+] Running 17/17
 ⠿ photoprism Pulled                                                                                                                                                                                              68.3s
   ⠿ 0509fae36eb0 Pull complete                                                                                                                                                                                    3.4s
   ⠿ 9aecf24919d0 Pull complete                                                                                                                                                                                    3.4s
   ⠿ 56fbc98970ca Pull complete                                                                                                                                                                                   62.1s
   ⠿ 4f4fb700ef54 Pull complete                                                                                                                                                                                   62.2s
   ⠿ 674dcffbc11c Pull complete                                                                                                                                                                                   62.2s
   ⠿ eb97349d77e1 Pull complete                                                                                                                                                                                   62.3s
   ⠿ d608e68af9e9 Pull complete                                                                                                                                                                                   65.8s
 ⠿ mariadb Pulled                                                                                                                                                                                                 44.4s
   ⠿ b2ddfd337773 Pull complete                                                                                                                                                                                    8.8s
   ⠿ 13535f17af4c Pull complete                                                                                                                                                                                    8.9s
   ⠿ 87f6d383d154 Pull complete                                                                                                                                                                                   10.4s
   ⠿ b9201b45023f Pull complete                                                                                                                                                                                   11.6s
   ⠿ acab8cdfe2ed Pull complete                                                                                                                                                                                   13.3s
   ⠿ d3ff62826dc9 Pull complete                                                                                                                                                                                   41.8s
   ⠿ f7907cb8a5ac Pull complete                                                                                                                                                                                   41.9s
   ⠿ 388bdb3b1bde Pull complete                                                                                                                                                                                   42.0s
[+] Running 3/3
 ⠿ Network photoprism_default         Created                                                                                                                                                                      0.2s
 ⠿ Container photoprism-mariadb-1     Started                                                                                                                                                                      1.3s
 ⠿ Container photoprism-photoprism-1  Started                                                                                                                                                                      1.0s
photoprism-photoprism-1  | started 221118-jammy as root (arm64-prod)
photoprism-photoprism-1  | Problems? Our Troubleshooting Checklists help you quickly diagnose and solve them:
photoprism-photoprism-1  | https://docs.photoprism.app/getting-started/troubleshooting/
photoprism-photoprism-1  | file umask....: "0002" (u=rwx,g=rwx,o=rx)
photoprism-photoprism-1  | home directory: /photoprism
photoprism-photoprism-1  | assets path...: /opt/photoprism/assets
photoprism-photoprism-1  | storage path..: /photoprism/storage
photoprism-photoprism-1  | config path...: default
photoprism-photoprism-1  | cache path....: default
photoprism-photoprism-1  | backup path...: /photoprism/storage/backups
photoprism-mariadb-1     | 2023-03-18 18:52:08+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.10.3+maria~ubu2204 started.
photoprism-mariadb-1     | 2023-03-18 18:52:08+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
photoprism-mariadb-1     | 2023-03-18 18:52:08+00:00 [Note] [Entrypoint]: Entrypoint script for MariaDB Server 1:10.10.3+maria~ubu2204 started.
photoprism-photoprism-1  | import path...: /photoprism/import
photoprism-photoprism-1  | originals path: /photoprism/originals
photoprism-photoprism-1  | running as uid 0
photoprism-photoprism-1  | /opt/photoprism/bin/photoprism start
photoprism-mariadb-1     | 2023-03-18 18:52:08+00:00 [Note] [Entrypoint]: Initializing database files
photoprism-mariadb-1     |
photoprism-mariadb-1     |
photoprism-mariadb-1     | PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
photoprism-mariadb-1     | To do so, start the server, then issue the following command:
photoprism-mariadb-1     |
photoprism-mariadb-1     | '/usr/bin/mariadb-secure-installation'
photoprism-mariadb-1     |
photoprism-mariadb-1     | which will also give you the option of removing the test
photoprism-mariadb-1     | databases and anonymous user created by default.  This is
photoprism-mariadb-1     | strongly recommended for production servers.
photoprism-mariadb-1     |
photoprism-mariadb-1     | See the MariaDB Knowledgebase at https://mariadb.com/kb
photoprism-mariadb-1     |
photoprism-mariadb-1     | Please report any problems at https://mariadb.org/jira
photoprism-mariadb-1     |
photoprism-mariadb-1     | The latest information about MariaDB is available at https://mariadb.org/.
photoprism-mariadb-1     |
photoprism-mariadb-1     | Consider joining MariaDB's strong and vibrant community:
photoprism-mariadb-1     | https://mariadb.org/get-involved/
photoprism-mariadb-1     |
photoprism-mariadb-1     | 2023-03-18 18:52:14+00:00 [Note] [Entrypoint]: Database files initialized
photoprism-mariadb-1     | 2023-03-18 18:52:14+00:00 [Note] [Entrypoint]: Starting temporary server
photoprism-mariadb-1     | 2023-03-18 18:52:14+00:00 [Note] [Entrypoint]: Waiting for server startup
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Warning] Setting lower_case_table_names=2 because file system for /var/lib/mysql/ is case insensitive
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] Starting MariaDB 10.10.3-MariaDB-1:10.10.3+maria~ubu2204 source revision cc8b9bcee3ce88bc52147948f96765cd5009b88a as process 92
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Number of transaction pools: 1
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Using ARMv8 crc32 + pmull instructions
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Using liburing
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Initializing buffer pool, total size = 512.000MiB, chunk size = 8.000MiB
photoprism-mariadb-1     | 2023-03-18 18:52:14 0 [Note] InnoDB: Completed initialization of buffer pool
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] InnoDB: Buffered log writes (block size=512 bytes)
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] InnoDB: 128 rollback segments are active.
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] InnoDB: Setting file './ibtmp1' size to 12.000MiB. Physically writing the file full; Please wait ...
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] InnoDB: File './ibtmp1' size is now 12.000MiB.
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] InnoDB: log sequence number 46456; transaction id 14
photoprism-mariadb-1     | 2023-03-18 18:52:15 0 [Note] Plugin 'FEEDBACK' is disabled.
photoprism-mariadb-1     | 2023-03-18 18:52:16 0 [Warning] 'user' entry 'root@17f562545436' ignored in --skip-name-resolve mode.
photoprism-mariadb-1     | 2023-03-18 18:52:16 0 [Warning] 'proxies_priv' entry '@% root@17f562545436' ignored in --skip-name-resolve mode.
photoprism-mariadb-1     | 2023-03-18 18:52:16 0 [Note] mysqld: ready for connections.
photoprism-mariadb-1     | Version: '10.10.3-MariaDB-1:10.10.3+maria~ubu2204'  socket: '/run/mysqld/mysqld.sock'  port: 0  mariadb.org binary distribution
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Temporary server started.
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Creating database photoprism
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Creating user photoprism
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Giving user photoprism access to schema photoprism
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Securing system users (equivalent to running mysql_secure_installation)
photoprism-mariadb-1     |
photoprism-mariadb-1     | 2023-03-18 18:52:16+00:00 [Note] [Entrypoint]: Stopping temporary server
photoprism-mariadb-1     | 2023-03-18 18:52:16 0 [Note] mysqld (initiated by: unknown): Normal shutdown
photoprism-mariadb-1     | 2023-03-18 18:52:16 0 [Note] InnoDB: FTS optimize thread exiting.
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Starting shutdown...
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Dumping buffer pool(s) to /var/lib/mysql/ib_buffer_pool
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Buffer pool(s) dump completed at 230318 18:52:17
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Removed temporary tablespace data file: "./ibtmp1"
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Shutdown completed; log sequence number 46456; transaction id 15
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] mysqld: Shutdown complete
photoprism-mariadb-1     |
photoprism-mariadb-1     | 2023-03-18 18:52:17+00:00 [Note] [Entrypoint]: Temporary server stopped
photoprism-mariadb-1     |
photoprism-photoprism-1  | time="2023-03-18T18:52:17Z" level=info msg="config: case-insensitive file system detected"
photoprism-mariadb-1     | 2023-03-18 18:52:17+00:00 [Note] [Entrypoint]: MariaDB init process done. Ready for start up.
photoprism-mariadb-1     |
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Warning] Setting lower_case_table_names=2 because file system for /var/lib/mysql/ is case insensitive
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] Starting MariaDB 10.10.3-MariaDB-1:10.10.3+maria~ubu2204 source revision cc8b9bcee3ce88bc52147948f96765cd5009b88a as process 1
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Compressed tables use zlib 1.2.11
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Number of transaction pools: 1
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Using ARMv8 crc32 + pmull instructions
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] mysqld: O_TMPFILE is not supported on /tmp (disabling future attempts)
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Using liburing
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Initializing buffer pool, total size = 512.000MiB, chunk size = 8.000MiB
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Completed initialization of buffer pool
photoprism-mariadb-1     | 2023-03-18 18:52:17 0 [Note] InnoDB: Buffered log writes (block size=512 bytes)
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: 128 rollback segments are active.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: Setting file './ibtmp1' size to 12.000MiB. Physically writing the file full; Please wait ...
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: File './ibtmp1' size is now 12.000MiB.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: log sequence number 46456; transaction id 14
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] Plugin 'FEEDBACK' is disabled.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Warning] You need to use --log-bin to make --expire-logs-days or --binlog-expire-logs-seconds work.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] InnoDB: Buffer pool(s) load completed at 230318 18:52:18
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] Server socket created on IP: '0.0.0.0'.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] Server socket created on IP: '::'.
photoprism-mariadb-1     | 2023-03-18 18:52:18 0 [Note] mysqld: ready for connections.
photoprism-mariadb-1     | Version: '10.10.3-MariaDB-1:10.10.3+maria~ubu2204'  socket: '/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution
photoprism-photoprism-1  | time="2023-03-18T18:52:22Z" level=info msg="PhotoPrism® needs your support!"
photoprism-photoprism-1  | time="2023-03-18T18:52:22Z" level=info msg="Visit https://photoprism.app/membership to learn more."
photoprism-photoprism-1  | time="2023-03-18T18:52:23Z" level=info msg="migrate: no previously executed migrations [pre]"
photoprism-photoprism-1  | time="2023-03-18T18:52:23Z" level=info msg="migrate: 20221015-100000 successful [4.522292ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:23Z" level=info msg="migrate: 20221015-100100 successful [7.927375ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: no previously executed migrations [main]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20211121-094727 successful [8.133084ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20211124-120008 successful [19.191375ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20220329-030000 successful [67.977083ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20220329-040000 successful [91.482709ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20220329-050000 successful [41.465625ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20220329-060000 successful [507.410625ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:28Z" level=info msg="migrate: 20220329-061000 successful [19.654542ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-070000 successful [41.415417ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-071000 successful [13.392667ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-080000 successful [87.723958ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-081000 successful [133.783875ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-083000 successful [17.70525ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-090000 successful [40.163291ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-091000 successful [17.823625ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220329-093000 successful [5.322083ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220421-200000 successful [37.673625ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220521-000001 successful [123.340625ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220521-000002 successful [31.199209ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220521-000003 successful [171.678375ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20220927-000100 successful [38.084958ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:29Z" level=info msg="migrate: 20221002-000100 successful [27.415041ms]"
photoprism-photoprism-1  | time="2023-03-18T18:52:31Z" level=info msg="server: enabling gzip compression"
photoprism-photoprism-1  | time="2023-03-18T18:52:31Z" level=info msg="webdav: /originals/ enabled, waiting for requests"
photoprism-photoprism-1  | time="2023-03-18T18:52:31Z" level=info msg="webdav: /import/ enabled, waiting for requests"
photoprism-photoprism-1  | time="2023-03-18T18:52:31Z" level=info msg="server: tls disabled"
photoprism-photoprism-1  | time="2023-03-18T18:52:31Z" level=info msg="server: listening on 0.0.0.0:2342 [11.31275ms]"
```

4. Start indexing

I accessed http://localhost:2342/library/index[Prism Index Page] and clicked on "Start".

![prism_index_page.png](/images/prism_index_page.png)

Then i had to be patient - i've never seen all cpu cores that busy for more than 2 minutes before:
![cpus_at_work.png](/images/cpus_at_work.png)

Indexing takes some time - you can see that currect status by looking at the ![Photoprism Menu](/images/photoprism_menu.png){:height="10%"}

Later i found out you can watch the indexer indexing by opening the `Logs` tab in the `Library` menu [as decribed here](https://docs.photoprism.app/user-guide/first-steps/#while-indexing-is-in-progress)

Stay tuned - i'll wait for the indexer to finish....