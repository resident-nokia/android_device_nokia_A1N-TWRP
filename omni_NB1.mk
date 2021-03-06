#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_DEVICE := NB1

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/embedded.mk)

# define hardware platform
PRODUCT_PLATFORM := msm8998
TARGET_USES_HARDWARE_QCOM_BOOTCTRL := true

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_verifier

PRODUCT_PACKAGES += \
    bootctrl.$(PRODUCT_PLATFORM) \
    update_engine_sideload

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.$(PRODUCT_PLATFORM) \
    libcutils \
    libgptutils \
    libz

# QCOM decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \

# Properties for decryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=msm8998 \
    ro.hardware.gatekeeper=msm8998 \
    ro.hardware.bootctrl=msm8998 \
    ro.vendor.build.security_patch=2099-12-31

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := \
    $(LOCAL_PATH)/recovery/root/etc/recovery.wipe	

# Timezone Data
PRODUCT_PACKAGES += \
    tzdata_twrp

# Product configs
PRODUCT_BRAND := Nokia
PRODUCT_MANUFACTURER := HMD Global
PRODUCT_DEVICE := NB1
PRODUCT_NAME := omni_NB1
PRODUCT_MODEL := Nokia 8