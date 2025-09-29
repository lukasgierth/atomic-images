#!/usr/bin/env bash

set -euo pipefail

echo "Disable rpm-ostree layering"
sed -i '/^#*LockLayering=.*/s/.*/LockLayering=true/' /etc/rpm-ostreed.conf

echo "Save package list to image"
/usr/bin/dnf5 list --installed > /usr/share/dnf5/packages_installed.txt

echo "Save repository list to image"
ls /etc/yum.repos.d > /usr/share/dnf5/repositories_files.txt
cat /etc/yum.repos.d/* > /usr/share/dnf5/repositories_installed.txt

echo "Delete repositories from image"
rm -r /etc/yum.repos.d

echo "Disable general usage of dnf & it's symlinks like yum"

package_managers=(
"/usr/bin/dnf"
"/usr/bin/dnf5"
"/usr/bin/yum"
"/usr/bin/microdnf"
)

for pkg_mgr in "${package_managers[@]}"; do
cat << EOF > "${pkg_mgr}"
#!/usr/bin/env bash
echo "Package/application layering is disabled to ensure that reliability & integrity of the system remains untouched!"
exit 1
EOF
done
