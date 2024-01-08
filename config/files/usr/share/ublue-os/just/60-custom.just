import '100-bling.just'
# Include some of your custom scripts here!

# Enable tpm2 LUKS auto-decryption via systemd-cryptenroll
enable-cryptenroll:
    #!/usr/bin/env bash
    set -euxo pipefail
    DISK_UUID=$(sudo awk '{ print $2 }' /etc/crypttab | cut -d= -f2)
    CRYPT_DISK="/dev/disk/by-uuid/$DISK_UUID"
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 $CRYPT_DISK
    rpm-ostree initramfs --enable --arg=--force-add --arg=tpm2-tss
