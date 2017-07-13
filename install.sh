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

# For usage, see README.md

ENTRY_FILE=uefi-firmware
PRIORITY=50
CONFIG_PATH=/boot/grub/grub.cfg
INSTALL_OUT=/etc/grub.d

# Args
if [ ! -z $1 ]; then PRIORITY=$1; fi    # Check if custom priority has been passed as argument
if [ ! -z $3 ]; then CONFIG_PATH=$3; fi # Check if custom config path has been passed as argument
if [ ! -z $4 ]; then INSTALL_OUT=$4; fi # Check if userdefined grub custom entries directory has been passed as argument

# Check which update script is used
if [ ! -z $2 ]; then GRUB_MKCONFIG=$2 # Custom upgrade script passed as argument
elif [ -x "$(command -v grub2-mkconfig)" ]; then GRUB_MKCONFIG=grub2-mkconfig;
elif [ -x "$(command -v grub-mkconfig)" ];  then GRUB_MKCONFIG=grub-mkconfig;
elif [ -x "$(command -v update-grub)" ];    then GRUB_MKCONFIG=update-grub;
else echo Failed to find grub-mkconfig;
fi;

# Script starts here #
cp $ENTRY_FILE $INSTALL_OUT/$PRIORITY\_$ENTRY_FILE
chmod +x $INSTALL_OUT/$PRIORITY\_$ENTRY_FILE

# Generate new grub cfg
$GRUB_MKCONFIG -o $CONFIG_PATH
