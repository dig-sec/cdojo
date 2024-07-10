# vagrant box list
# vagrant box remove windows_2022 --provider libvirt
# sudo vagrant box remove metasploitable3-win2k8 --provider virtualbox

# # Download windows server 2019
# https://app.vagrantup.com/StefanScherer/boxes/windows_2019/versions/2021.05.15/providers/virtualbox/unknown/vagrant.box
# # Download windows server 2022
# https://app.vagrantup.com/StefanScherer/boxes/windows_2022/versions/2021.08.23/providers/virtualbox/unknown/vagrant.box
# # Download windows 10
# https://app.vagrantup.com/StefanScherer/boxes/windows_10/versions/2021.12.09/providers/virtualbox/unknown/vagrant.box
# # Download windows 11
# https://app.vagrantup.com/StefanScherer/boxes/windows_11/versions/2021.12.09/providers/virtualbox/unknown/vagrant.box

# This script needs to be run usning high privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script needs to be run with sudo or as root." >&2
    exit 1
fi


# Append the links to machines
declare -A MACHINES
MACHINES=(
    ["windows_2019"]="https://app.vagrantup.com/StefanScherer/boxes/windows_2019/versions/2021.05.15/providers/virtualbox/unknown/vagrant.box"
    ["windows_2022"]="https://app.vagrantup.com/StefanScherer/boxes/windows_2022/versions/2021.08.23/providers/virtualbox/unknown/vagrant.box"
    ["windows_10"]="https://app.vagrantup.com/StefanScherer/boxes/windows_10/versions/2021.12.09/providers/virtualbox/unknown/vagrant.box"
    ["windows_11"]="https://app.vagrantup.com/StefanScherer/boxes/windows_11/versions/2021.12.09/providers/virtualbox/unknown/vagrant.box"
    ["metasploitable3-win2k8"]="https://app.vagrantup.com/rapid7/boxes/metasploitable3-win2k8/versions/0.1.0-weekly/providers/virtualbox/unknown/vagrant.box"
)

# Create folder machines
mkdir -p machines
cd machines

# Download machines to local folder then use vagrant mutate to convert to libvirt before adding the box.
for machine in "${!MACHINES[@]}"; do
    # Download the list of Machines in the list to machines folder if not already downloaded
    if [[ -f "$machine.box" ]]; then
        echo "Machine $machine already exists."
        continue
    fi
    wget -O "$machine.box" "${MACHINES[$machine]}"
done

for machine in "${!MACHINES[@]}"; do
    # Convert the downloaded machines to libvirt
    vagrant mutate "$machine.box" libvirt
    # Add the box to vagrant
    vagrant box add --name "$machine" "$machine.box"
    # Remove virtualbox box versions
    vagrant box remove "$machine" --provider virtualbox    
done