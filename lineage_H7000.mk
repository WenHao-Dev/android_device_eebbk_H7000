#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from H7000 device
$(call inherit-product, device/eebbk/H7000/device.mk)

PRODUCT_DEVICE := H7000
PRODUCT_NAME := lineage_H7000
PRODUCT_BRAND := EEBBK
PRODUCT_MODEL := S5
PRODUCT_MANUFACTURER := EEBBK

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="H7000-user 9.0 PKQ1.190319.001 V1.4.3_200818 release-keys"

BUILD_FINGERPRINT := EEBBK/H7000/H7000:9.0/PKQ1.190319.001/cp08181103:user/release-keys
