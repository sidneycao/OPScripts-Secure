#!/bin/bash

wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.24.0/blackbox_exporter-0.24.0.linux-amd64.tar.gz

tar blackbox_exporter-0.24.0.linux-amd64.tar.gz -C /etc/

cd /etc/

mv blackbox_exporter-0.24.0.linux-amd64 blackbox_exporter

echo -e "#Prometheus Blackbox Exporter Upstart script
[Unit]
Description=Blackbox Exporter
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/etc/blackbox_exporter/blackbox_exporter

[Install]
WantedBy=default.target" > /usr/lib/systemd/system/blackbox_exporter.service

systemctl daemon-reload
systemctl enable blackbox_exporter
systemctl start blackbox_exporter
systemctl status blackbox_exporter
