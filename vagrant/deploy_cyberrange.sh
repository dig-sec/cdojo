#!/bin/bash

# Ensure script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."
packages=("git" "ansible-core" "ruby" "ruby-dev" "qemu-kvm" "libvirt" "libvirt-dev" "ruby-libvirt")
for package in "${packages[@]}"; do
    if ! dnf install -y "$package" &>/dev/null; then  # Suppress output, check exit code
        echo "Error installing $package. Exiting."
        exit 1
    fi
done

# Add user to libvirt group
echo "Adding user to libvirt group..."
usermod -aG libvirt $USER

# Clone CyberRange repository
echo "Cloning CyberRange repository..."
if ! git clone git@github.com:dig-sec/CyberRange.git; then
    echo "Error cloning repository. Exiting."
    exit 1
fi
cd CyberRange

# Install Vagrant plugins
echo "Installing Vagrant plugins..."
vagrant plugin install vagrant-libvirt vagrant-hostmanager

# Start and enable libvirtd
systemctl enable --now libvirtd

# Manage bridges
bridges=("virbr2" "virbr3")
for bridge in "${bridges[@]}"; do
    echo -n "Checking bridge $bridge..."
    if virsh net-info "$bridge" &>/dev/null; then
        echo "already active."
    else
        echo -n "defining and starting..."
        virsh net-define "$bridge.xml" &>/dev/null
        virsh net-start "$bridge" &>/dev/null
        echo "done."
    fi
done

# Update bridge configuration if necessary
if ! grep -q 'allow all' /etc/qemu/bridge.conf; then
    echo 'allow all' | sudo tee -a /etc/qemu/bridge.conf >/dev/null 
fi

# Start Vagrant
echo "Starting Vagrant..."
if ! vagrant up --provider=libvirt; then
    echo "Error starting Vagrant. Please check the output for details."
    exit 1
fi

echo "Setup completed successfully!"
