#!/bin/bash

url="https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz"
wget $url

tar -zxvf node_exporter-1.5.0.linux-amd64.tar.gz -C /etc/

cd /etc/

mv node_exporter-1.5.0.linux-amd64 node_exporter

echo -e "#Prometheus Node Exporter Upstart script
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/etc/node_exporter/node_exporter

[Install]
WantedBy=default.target" > /usr/lib/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
