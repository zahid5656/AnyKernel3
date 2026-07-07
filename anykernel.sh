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
block=/dev/block/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# import functions/variables and setup patching - DO NOT REMOVE
. tools/ak3-core.sh;

ui_print "*******************************"
ui_print " OpenELA-LTS Kernel"
ui_print " Realme X2 Pro / Samurai"
ui_print " KernelSU-Next Test Build"
ui_print "*******************************"

ui_print "- Dumping current boot image..."
dump_boot;

ui_print "- Flashing kernel while preserving ROM ramdisk..."
write_boot;

# IMPORTANT:
# Do NOT flash dtbo during first boot test.
# Wrong dtbo can cause boot-loop or black screen.
# flash_dtbo;

sleep 1
ui_print "DONE!"
ui_print "Kernel Installed Successfully !!!"

## end install
