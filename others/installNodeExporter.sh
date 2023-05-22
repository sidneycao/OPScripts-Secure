#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

tar -zxvf node_exporter-1.5.0.linux-amd64.tar.gz -C /etc/

cd /etc/

mv node_exporter-1.5.0.linux-amd64 node_exporter

echo -e "#Prometheus Node Exporter Upstart script\n
[Unit]\n
Description=Node Exporter\n
Wants=network-online.target\n
After=network-online.target\n
\n
[Service]\n
ExecStart=/srv/node_exporter/node_exporter\n
\n
[Install]\n
WantedBy=default.target" > /usr/lib/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
