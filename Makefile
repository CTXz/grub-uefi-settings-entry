# GRUB is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GRUB is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GRUB.  If not, see <http://www.gnu.org/licenses/>.


ENTRY_FILE    := uefi-firmware
PRIORITY      := 50
INSTALL_OUT   := /etc/grub.d

GRUB_MKCONFIG := $(shell if   [ -x "$(command -v grub2-mkconfig)" ]; then echo grub2-mkconfig; \
			 elif [ -x "$(command -v update-grub)" ]; then echo update-grub; \
			 else echo grub-mkconfig; \
			 fi;)

GRUB_CFG      := /boot/grub/grub.cfg

install:
	cp $(ENTRY_FILE) $(INSTALL_OUT)/$(PRIORITY)_$(ENTRY_FILE)
	chmod +x $(INSTALL_OUT)/$(PRIORITY)_$(ENTRY_FILE)
	$(GRUB_MKCONFIG) -o $(GRUB_CFG)

uninstall:
	rm $(INSTALL_OUT)/*_$(ENTRY_FILE)
	$(GRUB_MKCONFIG) -o $(GRUB_CFG)	
