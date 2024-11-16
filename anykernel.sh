### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=OpenELA-LTS NetHunter Kernel for Realme X2 Pro
do.devicecheck=0
do.modules=1
do.systemless=0
do.cleanup=0
do.cleanuponabort=0
device.name1=samurai
device.name2=RMX1931
device.name3=RMX1931CN
supported.versions=
'; } # end properties

# boot shell variables
BLOCK=/dev/block/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
#PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

## AnyKernel boot install
#split_boot;
#flash_boot;
#flash_dtbo;

## AnyKernel boot install
dump_boot;
write_boot;

sleep 1
ui_print "DONE!"
ui_print "Kernel Installed Successfully !!!"

## end install
