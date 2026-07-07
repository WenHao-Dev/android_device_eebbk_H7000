# README

This project requires applying the following patches before use.

## Kernel Patch

Modify the `kernel` image to disable the `skip_initramf` flag by replacing it with `want_initramf` for 2 Stage Init System-as-Root:

```bash
sed -i 's/skip_initramf/want_initramf/g' kernel
```

Apply the following hexpatch to the kernel for pstore ramoops:

```patch
-019cf3c0: 0000 0000 0000 0000 0000 0e00 0000 0000  ................
+019cf3c0: 0000 0000 0000 0000 0000 4000 0000 0000  ..........@.....
-019cf3d0: 0090 11a0 0000 0000 0010 0000 0000 0000  ................
+019cf3d0: 0090 11a0 0000 0000 0010 0000 0000 0000  ................
-019cf3e0: 0000 0100 0000 0000 0010 0000 0000 0000  ................
+019cf3e0: 0000 0400 0000 0000 0010 0000 0000 0000  ................
-019cf3f0: 0000 0100 0000 0000 0100 0000 0000 0000  ................
+019cf3f0: 0000 0400 0000 0000 0100 0000 0000 0000  ................
```

## Device Tree (DTB) Patch

Apply the following patch to the device tree blob (DTB) for 2 Stage Init System-as-Root & pstore ramoops:

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
        };
    };

	reserved-memory {
		pstore-reserved-mem@a011a000 {
			compatible = "qcom,pstore";
-			reg = <0x00 0xa0119000 0x00 0xe0000>;
+			reg = <0x00 0xa0119000 0x00 0x400000>;
		};
    };
};
```

## Summary

The required modifications are:

- **Kernel:** Replace `skip_initramf` with `want_initramf` in the kernel image.
- **DTB:** Add the `boot_devices` property under `firmware/android` and remove the embedded Android `fstab` node.
