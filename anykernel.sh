### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
properties() { '
kernel.string=OpenELA-LTS Kernel for Realme X2 Pro
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=samurai
device.name2=RMX1931
device.name3=RMX1931CN
supported.versions=
supported.patchlevels=
'; } # end properties

# boot shell variables
BLOCK=/dev/block/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
#PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - DO NOT REMOVE
. tools/ak3-core.sh;

ui_print "*******************************"
ui_print " OpenELA-LTS Kernel"
ui_print " Realme X2 Pro / Samurai"
ui_print " KernelSU-Next Test Build"
ui_print "*******************************"

## AnyKernel boot install
split_boot;
flash_boot;
flash_dtbo;

sleep 1
ui_print "DONE!"
ui_print "Kernel Installed Successfully !!!"

## end install
