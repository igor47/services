#!/bin/bash

cp ~igor47/repos/igor.services/igor47.dc.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user --enable igor47.dc

systemctl --user status igor47.dc
