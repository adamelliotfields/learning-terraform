#cloud-config
users:
- name: ${user}
  gecos: ''
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  # /home/${user}/.ssh/authorized_keys
  ssh_authorized_keys:
  - '${rsa_public}'
ssh_keys:
  # /etc/ssh/ssh_host_rsa_key.pub
  rsa_public: '${rsa_public}'
  # /etc/ssh/ssh_host_rsa_key
  rsa_private: |
    ${indent(4, rsa_private)}
apt:
  preserve_sources_list: true
  sources:
    docker-ce.list:
      source: 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable'
      key: |
        ${indent(8, docker_gpg)}
package_upgrade: true
packages:
- debconf-utils
- docker-ce
- gnupg-agent
- iptables-persistent
- software-properties-common
write_files:
- path: /etc/ssh/sshd_config
  owner: root:root
  permissions: '0644'
  content: |
    ${indent(4, sshd_config)}
- path: /etc/iptables/rules.v4
  owner: root:root
  permissions: '0640'
  content: |
    ${indent(4, rules_v4)}
- path: /etc/iptables/rules.v6
  owner: root:root
  permissions: '0640'
  content: |
    ${indent(4, rules_v6)}
runcmd:
- 'echo br_netfilter >> /etc/modules'
- 'echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.conf'
- 'echo net.bridge.bridge-nf-call-ip6tables=1 >> /etc/sysctl.conf'
- 'sysctl -p > /dev/null'
- 'modprobe br_netfilter'
- 'echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections'
- 'echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections'
- 'wget -qO /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'
- 'chmod +x /usr/local/bin/jq'
- "echo '{\"iptables\":false,\"exec-opts\":[\"native.cgroupdriver=systemd\"]}' | jq -M . > /etc/docker/daemon.json"
- 'usermod -aG docker adam'
- 'systemctl restart docker.service'
- 'systemctl restart netfilter-persistent.service'
