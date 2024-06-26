#!/bin/bash

print_ascii_banner() {
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWXXWMWNWWWWWKKX0OXXK0NWWWWNWMWXXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWNXKXW0lcdkKK00000000KKKOdlckNNXXWWWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNNX00KXXl,:;:lok0000000Oolc;:,:0XK0KXXNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMWMMWWWNK0000KKKk;::..:c::clllc::cc'.,:,oKKK00000XWWWWMWWMMMWWMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMWWMMMMMMWWNKOO0000OOOOd,;,  .;dooxxxdodc.  .;,l0OO0000OOO0NWWWWMMMWWMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMNK0KNWWWN0OO00OkkkOOkOx;'..,cdxdoxkxddxdl;...,dOkOOOOOO00Ok0XWWWWK0KNWWWWMMMMMMMMMMMM"
echo "MMMMMMMMMMMMWNk:;ccxKX0kO0OkxkOOkOkk0kc..lkkkxdONNX0dxxkOd' ,x0OkOOOOkkkO0kkOXXklc;;xNMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMKc..:o:cxk00kxkkkkkxkOkxx:.;l::;,cOWWW0l;;::lc.,xxxOkxkkkkOkkO0kxo:ll..;0MMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMW0c. ...ckkxkkkkOxdkOOxdc.'lc;:,..oNWNk' .;,co;.cdxkOkdxkkkkOkxOo,....;OWMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMWKl. ..':dkddxkkkkkkkxl'.'colll:;xNWW0c;clldo,..lxxkkkkkOxddkxc,.. .c0WMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMWWWXl. ..':dkxkxxkkxxxdc..;odddOKKxllld0X0xddd:..:dxxxkkxxkkxdc,'. .:KWWMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMWWWNKkl' ..':oxxxxxkkkko:,''cdxkO0XO;'cxKKOkxdl,',;lxkkkxxxxxd:,.. .ck0XWNWMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMWNNko0O:.  .';okxddxdkxodxc..'cxOkkkdodxkkOkl,..;ddoxxdxooxko:'.. .;kKddXNWMMMMMMMMMMMMM"
echo "MMMMMMMMMMMWWW0lkKOd:.. .';oxdoxdxxoddc,'. .'ckKWWNXOl;.  .,:odoxxdxdoxo:'.. .;ok0OckWWWMMMMMMMMMMMM"
echo "MMMMMMMMMMWNNXoo0xoxdl'. .',ldxddOkdd:':o;..';;:lllc;;,. ,oc':odkOxdxxl,'. ..:ddod0ocKNNWMMMMMMMMMMM"
echo "MMMMMMMMMMWXNO:xOododxo,  .',:lc;:llo:'.;c;'ck0xolodOOo,,c;'.;lll:::c:,'.  'lxoodokk:xNXWMMMMMMMMMMM"
echo "MMMMMMMMMMMWWd:Oxcddxxkd' .','';lodkkd;..,c::xXX0O0XXOc:c;..,lxxdol:''''. .okxxddld0clNMMMMMMMMMMMMM"
echo "MMMMMMMMMMK0XxdKxokddxol:,''.'oOkoc:;::'..':c;dXWWWNk:;c,..';:;;:lxOd;...';loxxdxddKxoK00WMMMMMMMMMM"
echo "MMMMMMMMMWXXNoo0dokooxo;,:. 'x0xl,...',,'..'::,cO0Oo,:c,..',,,...':dOO; .,;;lxdokdoKxlKXXWMMMMMMMMMM"
echo "MMMMMMMMMX0NNcc0o:oddddooxl.ckl:,'.. .',,'...,;',,.'::'..',''.  ..,:cxo.:ddddddddcc0l;KN0XWMMMMMMMMM"
echo "MMMMMMMMMWNNNl;Oo:lddooooo:,dd:;'..   ........''..;:;........   ..';:od,,oooooddo:lOc:XNXWMWMMMMMMMM"
echo "MMMMMMMMMMXXWd'xxclodolloc'ldc:;...    .........';,,........    ...;c:ol,:olloddocdk,lWNXWMMMMMMMMMM"
echo "MMMMMMMMMMWNW0,cklcloollo,,c;;;,...  .ckOkl'. ..'...  ..cxOko.   ..,;;,c;,llcoolcckl'kWWWWWMMMMMMMMM"
echo "MMMMMMMMWMMNNWo'xxccc::lc.';',,'...  .cdkOl,.,lc;...',.,ckOxo,   ..',,,;,.:o::cccxk,cNWNWMMMMMMMMMMM"
echo "MMMMMMMMWWMWXKK;,ko;cc;::.',.,,,,,::.....'..,dkOOxdddo'..'.....;:;,,,,','.;:;::;lO:,0KKWMMMMMMMMMMMM"
echo "MMMMMMMMMWMWK0WO,:x:.co:;'...';;;;;',xo'ckxc'';clodddc;lkOd'cx;.,;;;;'....,;lc.,xl'kW00WMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMX0k,:x:':,........',..oOc,dxdoc;'.....';:lodx;;kx,.',........,:,;xc'x0KMWMMMMMMMMMMMMM"
echo "MMMMMMMMMWMMMWK0N0;;dl,':o;. .......:c;,;:c;,..     ..';::;,,::'..'.... .:c;':d:,kNKKWWWMMMMMMMMMMMM"
echo "MMMMMMMMWWMMWKkxdxd:cdc:c.      ....,,',...             ...''',.....     .'::do:oxdxkKWWMMMMMMMMMMMM"
echo "MMMMMMMMMWWKc..........   ..  .......,,..... .....       ....'.. ....       ..........:OWMMMMMMMMMMM"
echo "MMMMMMMMMMX: .dOxkk,.lk, 'xo.;0Odxx; ;0Oxxd'.x0xdkOo.   ;0Odxx,.:xdxOl.    .dx.,kkkOx' ;KMMMMMMMMMMM"
echo "MMMMMMMMMM0' cNo.,o; .Ok,d0, :Nd.:Xd.cNo... .OO'.kMK,   :Xd.:Xd,OO,,OO'    .kO'oNl.oNl .OMMMMMMMMMMM"
echo "MMMMMMMMMM0' cNl      ,0X0:  :NKxOXl cW0do' .OXxxKWO.   :No ;Kd,Ok..kO'    .kO'oN: lNl .OMMMMMMMMMMM"
echo "MMMMMMMMMM0' :0:  ..   cKo.  ;0x,cOo.:Kd;,. .kOcxK0c    ;0l ,0o'kx..xk. .. .xk'l0; :0c .OMMMMMMMMMMM"
echo "MMMMMMMMMM0, ;Ol.:kl   ;Oc   ;Oo.;Od.;0l.....xx.'OXo.   ;Oo.:Ol'xk,,kx.,kl.,kx.c0c.l0: .OMMMMMMMMMMM"
echo "MMMMMMMMMMNc .cdddo'   'd;   'ddool' ,ddooo'.ll. :xd'   'ddodl' ,oddd; .cdddd, .lddxl. ;KMMMMMMMMMMM"
echo "MMMMMMMMMWMXo'......;. ..... ......   .......................  .. ....,'......;'......lKMMMMMMMMMMMM"
echo "MMMMMMMMMMWMMN0kkkOXNKOOOO00OOOko,...,dx:,'..'.''''''.''.',od;....cxOKWN0OkkOXWX0kkkOXWMMMMMMMMMMMMM"
echo "                                                                                          @pabi 2024"
}

# Constants and Configuration
PACKAGES=(
    "git" "ansible-core" "ruby" "ruby-devel" "qemu-kvm" "libvirt" 
    "libvirt-devel" "gcc" "make" "patch" "python3" "python3-pip" "sshpass"
)
BRIDGES=("virbr2" "virbr3" "virbr4" "default")
BRIDGE_CONFIG="/etc/qemu/bridge.conf"
BRIDGE_XML_DIR="/etc/libvirt/qemu/networks"

# Default bridge configurations
DEFAULT_BRIDGE_CONFIG=$(cat <<EOF
<network>
  <name>default</name>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:0a:cd:20'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.100'/>
    </dhcp>
  </ip>
</network>
EOF
)

# Bridge configurations
BRIDGE_CONFIGS=(
    ["virbr2"]=$(cat <<EOF
<network>
  <name>virbr2</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr2' stp='on' delay='0'/>
  <ip address='10.0.1.1' netmask='255.255.255.0'/>
</network>
EOF
)
    ["virbr3"]=$(cat <<EOF
<network>
  <name>virbr3</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr3' stp='on' delay='0'/>
  <ip address='10.0.2.1' netmask='255.255.255.0'/>
</network>
EOF
)
    ["virbr4"]=$(cat <<EOF
<network>
  <name>virbr4</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr4' stp='on' delay='0'/>
  <ip address='172.16.0.1' netmask='255.255.255.0'/>
</network>
EOF
)
)

# Functions
install_packages() {
    echo "Installing dependencies..."
    sudo dnf install -y "${PACKAGES[@]}" || { echo "Error installing packages. Exiting."; exit 1; }
}

install_vagrant() {
    echo "Installing Vagrant..."
    sudo dnf install -y vagrant || { echo "Error installing Vagrant. Exiting."; exit 1; }
}

install_gem() {
    gem_name="$1"
    echo "Installing Ruby gem $gem_name..."
    sudo /usr/bin/gem install "$gem_name" || { echo "Error installing Ruby gem $gem_name."; exit 1; }
    echo "Ruby gem $gem_name installed successfully."
}

install_vagrant_plugin() {
    plugin_name="$1"
    echo "Installing Vagrant plugin $plugin_name..."
    vagrant plugin install "$plugin_name" || { 
        echo "Error installing Vagrant plugin $plugin_name. Please check the output for details."; 
        vagrant plugin install "$plugin_name" --verbose  # Retry with verbose output for troubleshooting
        exit 1
    }
    echo "Vagrant plugin $plugin_name installed successfully."
}

check_bridge_status() {
    for bridge in "${BRIDGES[@]}"; do
        echo -n "Checking bridge $bridge..."
        if virsh net-info "$bridge" &>/dev/null; then
            echo "active."
        else
            echo "inactive or not defined."
        fi
    done
}

configure_bridges() {
    echo "Configuring bridges..."
    for bridge in "${!BRIDGE_CONFIGS[@]}"; do
        if virsh net-info "$bridge" &>/dev/null; then
            echo "Bridge $bridge already exists."
        else
            echo "Creating bridge $bridge..."
            echo "${BRIDGE_CONFIGS[$bridge]}" | sudo tee "$BRIDGE_XML_DIR/$bridge.xml" >/dev/null
            sudo virsh net-define "$BRIDGE_XML_DIR/$bridge.xml"
            sudo virsh net-start "$bridge"
        fi
    done
}

update_bridge_config() {
    echo "Updating bridge configuration..."
    if [[ -f "$BRIDGE_CONFIG" ]]; then
        echo "Bridge configuration file $BRIDGE_CONFIG already exists."
    else
        echo "Creating bridge configuration file $BRIDGE_CONFIG..."
        for bridge in "${BRIDGES[@]}"; do
            echo "allow $bridge" | sudo tee -a "$BRIDGE_CONFIG" >/dev/null
        done
    fi
}

enable_autostart() {
    for bridge in "${BRIDGES[@]}"; do
        sudo virsh net-autostart "$bridge" >/dev/null 2>&1
        echo "Autostart enabled for bridge $bridge."
    done
}

main() {
    print_ascii_banner
    # Check if running as root (or with sudo)
    if [[ $EUID -ne 0 ]]; then
        echo "This script needs to be run with sudo or as root." >&2
        exit 1
    fi

    # Create bridge XML directory
    mkdir -p "$BRIDGE_XML_DIR"
    echo "$DEFAULT_BRIDGE_CONFIG" | sudo tee "$BRIDGE_XML_DIR/default.xml" >/dev/null
    configure_bridges
    enable_autostart
    update_bridge_config
    check_bridge_status

    # Installation Steps
    install_packages
    install_vagrant
    install_gem winrm
    install_vagrant_plugin vagrant-libvirt
    install_vagrant_plugin winrm
    install_vagrant_plugin winrm-elevated
    install_vagrant_plugin vagrant-hostmanager
    install_vagrant_plugin mutate

    # Install Ansible collections
    echo "Installing Ansible collections..."
    ansible-galaxy collection install ansible.windows puzzle.opnsense microsoft.ad community.general community.windows

    # Add user to libvirt and qemu groups and restart libvirtd
    sudo usermod -aG libvirt "$USER"
    sudo usermod -aG qemu "$USER"
    sudo systemctl restart libvirtd

    echo "Setup completed successfully!"
}

main
