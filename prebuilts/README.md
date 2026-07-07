# README

This project requires applying the following patches before use.

## Kernel Patch

Modify the `kernel` image to disable the `skip_initramf` flag by replacing it with `want_initramf`:

```bash
sed -i 's/skip_initramf/want_initramf/g' kernel
```

## Device Tree (DTB) Patch

Apply the following patch to the device tree blob (DTB):

```patch
/ {
    firmware {
        android {
            compatible = "android,firmware";
+           boot_devices = "soc/c0c4000.sdhci";
-
-           fstab {
-               compatible = "android,fstab";
-
-               vendor {
-                   compatible = "android,vendor";
-                   dev = "/dev/block/platform/soc/c0c4000.sdhci/by-name/vendor";
-                   type = "ext4";
-                   mnt_flags = "ro,barrier=1,discard";
-                   fsmgr_flags = "wait,verify";
-                   status = "ok";
-               };
-           };
-       };
    };
};
```

## Summary

The required modifications are:

- **Kernel:** Replace `skip_initramf` with `want_initramf` in the kernel image.
- **DTB:** Add the `boot_devices` property under `firmware/android` and remove the embedded Android `fstab` node.
