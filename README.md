# Grub UEFI Settings Entry Adder
The following repository adds a grub bootloader entry to boot into your UEFI/BIOS firmware settings

### Credit
The underlying grub entry script (`uefi-firmware`) is a trimmed down version of [this script](https://jsherz.com/centos/grub/grub2/bios/uefi/boot/2015/11/21/centos-uefi-firmware-option.html) distributed by jsherz.com. The conditions have been removed as they no longer apply to recent linux versions. It shall be noted that I have NOT replaced the conditions, but rather removed them, hence I should remind you that the grub entry may not function on every device, depending on it's linux setup, version and the hardware.

### Installation

In addition to the script itself, I have added a makefile which acts as installer and uninstaller. If, for various reasons, the GNU make tool is not present or fails to function, alternatively the installation and uninstallation bash scripts may be used. Finally, if the provided installation methods failed or the user is sceptical permitting the script su/sudo rights, a step by step manual installation may be done.

#### Cloning the repo
To locally obtain a copy of this repository, execute the following command :

```sh
git clone https://github.com/CTXz/grub_uefi_settings_entry.git 
```

As a result, a local copy of the repository will be located under the current directory

#### Method 1 - Make
To install and add the entry to your grub bootloader, execute the following command with _su_ rights inside the repository
```sh
$ make install
```

To revert all changes and remove the entry from your grub bootloader, execute the following command with _su_ rights inside the repository
```sh
$ make uninstall
```

#### Method 2 - Install scripts
To install and add the entry to your grub bootloader, execute the following command with _su_ rights inside the repository
```sh
$ sh install.sh [PRIORITY] [MKCONFIG] [MKCONFIG_OUT] [CUSTOM_ENTRY_DIR]
```

To revert all changes and remove the entry from your grub bootloader, execute the following command with _su_ rights inside the repository
```sh
$ sh uninstall.sh [MKCONFIG] [MKCONFIG_OUT] [CUSTOM_ENTRY_DIR]
```

Args:

|Name|Description|Default value|
|----|-----------|-------------|
|`PRIORITY`|Defines the entries read priority, which is prefixed ot the script (ex. `50_uefi-firmware`). The higher the number the higher the priority.|50|
|`MKCONFIG`|Defines the grub-mkconfig tool/executable. Depending on the distribution, this may differ. Ex. Debian based systems use the update-grub script, arch uses the standart grub-mkconfig where most distros however use grub2-mkconfig|Detected|
|`MKCONFIG_OUT`|Defines output paramter path (`-o`) of the MKCONFIG tool.|`/boot/grub/grub.cfg`|
|`CUSTOM_ENTRY_DIR`|Defines grub directory for custom menu entries|`/etc/grub.d/`|

#### Method 3 - Manual installation
1. Copy the entry script with a assigned priority (say `50`) into the grub custom entry directory, which by default, is located under `/etc/grub.d/`
```sh
$ cp uefi-firmware /etc/grub.d/50_uefi-firmware
```

2. Grant execution rights
```sh
$ chmod +x /etc/grub.d/50_uefi-firmware
```

3. Update grub. This command may vary across distribution

##### Debian based systems
```sh
$ update-grub
```

##### Most systems
```sh
$ grub-mkconfig -o /boot/grub/grub.cfg
or
$ grub2-mkconfig -o /boot/grub/grub.cfg
```
