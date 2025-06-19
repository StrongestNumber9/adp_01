#!/bin/bash
# Common scripts
bash /scripts/patch_resolv.sh;
bash /scripts/patch_hosts.sh;
bash /scripts/restore_ipa.sh || exit 1;

bash /scripts/copy_config.sh /config/hdp-03/ /opt/teragrep/hdp_03/etc/hadoop/ root:hadoop;
bash /scripts/copy_config.sh /config/spk-02/ /opt/teragrep/spk_02/conf/ root:root;

# Get keytab
kinit -kt /etc/krb5.keytab;
mkdir -p /opt/teragrep/hdp_03/keytabs/;

get_keytab() {
    echo "Getting keytab ${1}";
    ipa-getkeytab -s "ipa.${IPA_DOMAIN}" -p "${1}/$(hostname).${IPA_DOMAIN,,}@${IPA_DOMAIN^^}" -k "/opt/teragrep/hdp_03/keytabs/${1}.service.keytab";
}

for keytab in "${@}"; do
    get_keytab "${keytab}";
done;

chown -R root:hadoop /opt/teragrep/hdp_03/keytabs/;
chmod 755 /opt/teragrep/hdp_03/keytabs;
chmod 644 /opt/teragrep/hdp_03/keytabs/*.keytab;
