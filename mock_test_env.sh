#!/bin/bash

set -e

echo "Installing Ansible on AlmaLinux..."
if ! command -v ansible &>/dev/null; then
    sudo dnf install -y epel-release
    sudo dnf install -y ansible
fi

echo "Setting up QA Automation directory structure..."
mkdir -p ~/{sub,QA_SNAPSHOTS,DB_BACKUPS}
cd ~

cat > qa_config <<EOF
flavor=stage
auto-update=true
postgres-db-name=spire_db
postgres-db-host=localhost
elastic-db-host=localhost
elastic-db-clustername=es-cluster
elastic-db-nodename=node-1
adjudication-db-name=adj_db
elastic_internal_port=9200
elastic_member=qa-team
elastic_group=group1
EOF

echo "Creating mock property files..."
sudo mkdir -p /genkey_internal/3/ext/STAGE/runtime/adjudication/
sudo touch /genkey_internal/3/ext/STAGE/stage-db-spire.properties
sudo touch /genkey_internal/3/ext/STAGE/runtime/adjudication/cluster.properties

echo "Creating mock auto_update and custom_tools scripts..."
cat > sub/auto_update <<EOF
#!/bin/bash
echo "Auto Update Triggered!"
EOF

cat > sub/custom_tools <<EOF
#!/bin/bash
echo "Custom Tools Executed with command: \$1"
EOF

chmod +x sub/*


echo "Creating mock systemd service files..."
for svc in spire_web spire_rest adjudication adjudication_gateway; do
    sudo bash -c "cat > /etc/systemd/system/${svc}.service <<EOF
[Unit]
Description=Mock $svc Service
[Service]
ExecStart=/bin/sleep infinity
[Install]
WantedBy=multi-user.target
EOF"
done

echo "Reloading systemd and enabling mock services..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now spire_web spire_rest adjudication adjudication_gateway

echo "Setup complete!"
