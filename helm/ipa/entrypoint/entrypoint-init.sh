#!/bin/bash
bash /entrypoint-common.sh

if [ -f /data/data.tar ]; then
    echo "Skipping init, already done.";
    systemctl exit 0;
fi;

echo "Bootstrapping server";
ipa-server-install --unattended --domain "{{.Values.ipa.domain | lower}}" --realm "{{.Values.ipa.domain | upper}}" --ds-password "{{.Values.ipa.password}}" --admin-password "{{.Values.ipa.password}}" --setup-dns --forwarder "{{.Values.ipa.forwarder}}" --forward-policy only --no-ntp --auto-reverse;

echo "Running start-up scripts inside /config";
for file in /config/*.sh; do
    echo "Executing init script ${file}";
    bash "${file}";
done;

echo "Creating data dump";
tar -cf /data/data.tar /etc/authselect/nsswitch.conf /etc/authselect/user-nsswitch.conf /etc/certmonger/ /etc/dirsrv/ /etc/gssproxy/ /etc/httpd/alias/ /etc/httpd/conf/ /etc/httpd/conf.d/ /etc/ipa/ /etc/krb5.conf /etc/krb5.conf.d/ /etc/krb5.keytab /etc/machine-id /etc/named.conf /etc/named.keytab /etc/named/ /etc/nsswitch.conf /etc/openldap/ /etc/pam.d/ /etc/pki/ca-trust/ /etc/pki/nssdb/ /etc/pki/pki-tomcat /etc/pki/tls/certs/ /etc/pkcs11/modules/ /etc/rndc.key /etc/samba/ /etc/sssd/ /etc/sysconfig/ /etc/systemd/system/ /etc/tmpfiles.d/ /root/ca-agent.p12 /root/cacert.p12 /root/.dogtag/ /var/kerberos/krb5kdc/ /var/lib/certmonger/cas/ /var/lib/certmonger/local/ /var/lib/certmonger/requests/ /var/lib/dirsrv/ /var/lib/ipa/ /var/lib/ipa-client/ /var/lib/pki/ /var/lib/samba/ /var/lib/softhsm/tokens/ /var/lib/sss/db/ /var/lib/sss/keytabs/ /var/lib/sss/mc/ /var/lib/sss/pipes/private/ /var/lib/sss/pubconf/ /var/lib/systemd/ /var/lib/tpm2-tss/ /var/log/dirsrv/ /var/log/httpd/ /var/log/ipa/ /var/log/ipa*.log /var/log/kadmind.log /var/log/krb5kdc.log /var/log/pki/ /var/log/samba/ /var/log/sssd/ /var/named/ /var/lib/gssproxy/ /var/lib/chrony/ /var/tmp/ /tmp/;

echo "Exiting";
systemctl exit 0;
