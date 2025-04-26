# OJS Development Environment (Dockerized)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Docker Compose](https://img.shields.io/badge/docker--compose-v2-blue)](https://docs.docker.com/compose/)

This project provides a clean and minimal Docker Compose setup to run [Open Journal Systems (OJS)](https://pkp.sfu.ca/ojs/) for local development, testing, or demos.

- **OJS Version**: 3.4.x (tested)
- **Database**: MariaDB 11.x
- **Web Server**: Apache + PHP 8.1

---

## ⚙️ Requirements

- Docker (20.x or newer recommended)
- Docker Compose (v2+ recommended)
- GNU Make (optional but highly recommended for easier commands)

> **Windows users**: You can install Make easily with [Chocolatey](https://chocolatey.org/) via:
>
> ```bash
> choco install make
> ```

---

## 🚀 Quick Start

```bash
git clone https://github.com/jotanavarro/ojs_playground.git
cd ojs-docker-dev
cp .env.example .env
make up
```

Visit:
- OJS: [http://localhost:8080](http://localhost:8080)
- Adminer (Database manager): [http://localhost:8081](http://localhost:8081)
- Mailhog (Email testing): [http://localhost:8025](http://localhost:8025)

Complete the OJS Web Installer manually at first boot.

---

## 📚 Services Overview

| Service | URL | Purpose |
|:---|:---|:---|
| OJS (PHP/Apache) | [http://localhost:8080](http://localhost:8080) | Main application |
| MariaDB | Internal (no direct web URL) | Database backend |
| Adminer | [http://localhost:8081](http://localhost:8081) | Visual DB management |
| Mailhog | [http://localhost:8025](http://localhost:8025) | Captures outgoing emails |

---

## 🚿 Folder Structure

```plaintext
ojs-docker-dev/
├── docker-compose.yml
├── .env.example
├── mariadb/
│   ├── Dockerfile
│   └── my_custom.cnf
├── ojs/
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── apache-logs.conf
│   ├── config.inc.php.template
└── README.md
```

---

## 📦 Installation Notes

- During OJS web installation:
  - **Database Driver**: MySQLi
  - **Database Host**: `db`
  - **Database Name**: `ojs_db`
  - **Database Username**: `ojs_user`
  - **Database Password**: as defined in your `.env`

> ⚠️ Ensure the database name matches `MYSQL_DATABASE` defined in your `.env` file!

- SMTP Server for development is already wired to Mailhog.

---

## 📅 Useful Commands (Makefile Based)

| Command | Action |
|:---|:---|
| `make up` | Build and bring up all containers |
| `make down` | Stop and remove containers + volumes |
| `make build` | Build images in parallel |
| `make logs` | Follow container logs |
| `make shell` | Open shell in OJS container |

---

## 🚷 Known Limitations

- **OJS Installation must be completed manually** via the web UI after the first boot.
- **No auto-generated database**: installation will create the database schema during setup.
- **Admin credentials are chosen during manual install**.


---

## 💡 Future Improvements

- Optionally preload a database dump if needed.
- Add a production-ready setup with SSL (Let's Encrypt).
- Create Helm charts for Kubernetes deployments.

---

## 👥 Credits

Created and maintained by [Jose Navarro](https://github.com/jotanavarro).

Open to community contributions!

