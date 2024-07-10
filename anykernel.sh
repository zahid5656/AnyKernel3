### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=HyperTeam Openela Kernel for Realme X2 Pro
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=samurai
device.name2=RMX1931
device.name3=RMX1931CN
supported.versions=
'; } # end properties

# boot shell variables
block=/dev/block/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
#patch_vbmeta_flag=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

## AnyKernel boot install
split_boot;
flash_boot;
flash_dtbo;

## AnyKernel boot install
#dump_boot;
#write_boot;

## end install

sleep 1
ui_print " "
ui_print "DONE!"
ui_print "Kernel Installed Successfully !!!"
