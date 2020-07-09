# Docker Swarm Zabbix monitoring

Based on https://github.com/kulpin74/zabbix-swarm

What's different here is the way to connect to the Docker socket.

Instead of relying on it being exposed via TCP and using certificates for
authentication this template uses the agent protocol.

# Installation

## Agent setup

### Socket access

First you need to make sure that the user running zabbix-agent has access to
the Docker socket.

This is platform dependent, **most** of the time you simply need to add the
`zabbix-agent` to the `docker` group:

```bash
sudo gpasswd -a zabbix-agent docker
```

### Agent configuration

1. Place `zbx-docker-swarm.sh` in a directory that lies within `zabbix-agent`'s `PATH`.
2. Copy `zabbix_agentd.d/docker-swarm.conf` to your agent-config directory.

## Zabbix Server setup

1. Import `zabbix_template_docker_swarm.xml`.
2. Apply the `Template App Docker Swarm` template to your host(s).
