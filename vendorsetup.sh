#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2020 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it

FDEVICE="davinci"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

	# Allow missing dependencies
        export ALLOW_MISSING_DEPENDENCIES=true
   
    	#Set locale to C
    	export LC_ALL="C"
    
    	# Arch
    	export TARGET_ARCH="arm64"
    
    	# Platform Info
    	export PLATFORM_VERSION="16.1.0"
    	export PLATFORM_SECURITY_PATCH="2099-12-31"
   	
    	# Default Language
    	export TW_DEFAULT_LANGUAGE="en"
    
    	# Magisk Boot
    	export OF_USE_MAGISKBOOT=1
    	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
    	export OF_FORCE_MAGISKBOOT_BOOT_PATCH_MIUI=1
	export OF_USE_NEW_MAGISKBOOT=1
    
    	# Encryption Patches
    	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    	export OF_KEEP_FORCED_ENCRYPTION=1
    	#export OF_SKIP_FBE_DECRYPTION=1
    	#export OF_FBE_METADATA_MOUNT_IGNORE=0
    	#export OF_NO_RELOAD_AFTER_DECRYPTION=1
    	#export OF_OTA_RES_DECRYPT=1
    
    	# Replace stripped down ps command
    	export FOX_REPLACE_BUSYBOX_PS=1

    	# Build tar support
    	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
    
    	# Build Nano editor
    	export FOX_USE_NANO_EDITOR=1
    
    	# Use bash shell
    	export FOX_USE_BASH_SHELL=1
    	export FOX_ASH_IS_BASH=1
    
    	# Use TWRP Recovery Image Build Tools
    	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    
    	# Reset fox settings on installer
    	export FOX_RESET_SETTINGS=1
    
    	# Enable flashlight
    	export OF_FLASHLIGHT_ENABLE=1
    
    	# Set Fox version
    	export FOX_VERSION="R11"
    
    	# Set maintainer name
    	export OF_MAINTAINER="JairoAbreu"
    
    	# Scale to aspect ratio
    	export OF_SCREEN_H=2340
    
    	#Recover from OTA Fail
    	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    
    	# Patch AVB2.0
    	export OF_PATCH_AVB20=1

	#Button lockscreen
	export OF_USE_LOCKSCREEN_BUTTON=1

	# App Manager and AromaFM
	export FOX_DISABLE_APP_MANAGER=1
	export FOX_DELETE_AROMAFM=1

    	# Fix multiuser backup issues
    	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    
    	# Auto SAR detect
    	export OF_USE_TWRP_SAR_DETECT=1
    
    	# Fox R11 features
    	export FOX_R11=1
	export FOX_BUILD_TYPE="Beta"
	export FOX_VERSION=R11.0_0
    	# Quick Backup Entries
    	export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
    	# Use advanced security
    	export FOX_ADVANCED_SECURITY=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

	add_lunch_combo omni_"$FDEVICE"-eng
	add_lunch_combo omni_"$FDEVICE"-userdebug
fi
#
