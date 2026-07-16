### AnyKernel3 Ramdisk Mod Script
## zahid5656 @ github.com
## OpenELA-LTS Kernel for Realme X2 Pro / samurai

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
device.name3=RMX1931L1
device.name4=RMX1931EX
device.name5=RMX1931CN
supported.versions=
supported.patchlevels=
'; } # end properties

### Realme X2 Pro / samurai boot configuration
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
#PATCH_VBMETA_FLAG=auto;

### Locate the non-A/B boot partition before flashing
BLOCK="";

if [ -b /dev/block/by-name/boot ]; then
  BLOCK=/dev/block/by-name/boot;
elif [ -b /dev/block/bootdevice/by-name/boot ]; then
  BLOCK=/dev/block/bootdevice/by-name/boot;
fi;

### Import AnyKernel3 functions/variables
# DO NOT REMOVE
. tools/ak3-core.sh;

### Validate the detected boot partition
if [ -z "$BLOCK" ] || [ ! -b "$BLOCK" ]; then
  abort \
    "ERROR: Boot partition block device was not found." \
    "Checked:" \
    "  /dev/block/by-name/boot" \
    "  /dev/block/bootdevice/by-name/boot" \
    "Nothing was flashed.";
fi;

RESOLVED_BLOCK="$(readlink -f "$BLOCK" 2>/dev/null)";
[ -n "$RESOLVED_BLOCK" ] || RESOLVED_BLOCK="$BLOCK";

### Select kernel payload
# Prefer Image.gz-dtb for samurai.
# Fall back to Image.gz when Image.gz-dtb is unavailable.
KERNEL_PAYLOAD="";

if [ -s "$AKHOME/Image.gz-dtb" ]; then
  KERNEL_PAYLOAD=Image.gz-dtb;
elif [ -s "$AKHOME/Image.gz" ]; then
  KERNEL_PAYLOAD=Image.gz;
else
  abort \
    "ERROR: No supported kernel payload was found." \
    "Required at least one of:" \
    "  Image.gz-dtb" \
    "  Image.gz" \
    "Nothing was flashed.";
fi;

### Prevent AK3 from selecting another kernel build output
disable_kernel_candidate() {
  [ "$1" = "$KERNEL_PAYLOAD" ] && return 0;

  if [ -e "$AKHOME/$1" ]; then
    mv -f "$AKHOME/$1" "$AKHOME/$1.not-selected" || \
      abort \
        "ERROR: Failed to isolate kernel payload: $1" \
        "Nothing was flashed.";
  fi;
}

disable_kernel_candidate zImage;
disable_kernel_candidate zImage-dtb;
disable_kernel_candidate Image;
disable_kernel_candidate Image-dtb;
disable_kernel_candidate Image.gz;
disable_kernel_candidate Image.gz-dtb;

### Validate dtbo before boot flashing starts
if [ ! -s "$AKHOME/dtbo.img" ]; then
  abort \
    "ERROR: dtbo.img is missing or empty." \
    "Nothing was flashed.";
fi;

ui_print " ";
ui_print "*******************************";
ui_print " OpenELA-LTS Kernel";
ui_print " Realme X2 Pro / Samurai";
ui_print "*******************************";
ui_print "Boot partition:";
ui_print "  $BLOCK";
ui_print "Resolved block:";
ui_print "  $RESOLVED_BLOCK";
ui_print "Kernel payload:";
ui_print "  $KERNEL_PAYLOAD";
ui_print "DTBO payload:";
ui_print "  dtbo.img";
ui_print "Slot mode:";
ui_print "  Non-A/B";
ui_print "*******************************";
ui_print " ";

### Current working installation sequence
split_boot;
flash_boot;
flash_dtbo;

sleep 1;

ui_print " ";
ui_print "DONE!";
ui_print "Kernel installed successfully.";
ui_print "Kernel payload: $KERNEL_PAYLOAD";
ui_print "Boot partition: $BLOCK";
ui_print "DTBO partition flashed successfully.";

### End installation
