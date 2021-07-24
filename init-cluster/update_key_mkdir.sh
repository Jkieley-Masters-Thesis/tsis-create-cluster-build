rm -f /root/.ssh/authorized_keys
cp /home/ubuntu/.ssh/authorized_keys /root/.ssh #enables us to scp as root user non-interactive
mkdir /to-mount-data-dir # to be mounted as host path
chmod 777 /to-mount-data-dir