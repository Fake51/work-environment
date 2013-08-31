#!/bin/bash
/usr/sbin/smtp-sink -d %Y%m%d/%M -u postfix -R /var/log/email-trap 127.0.0.1:25 100
