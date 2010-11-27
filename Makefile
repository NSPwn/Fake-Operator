SYSROOT = /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.2.sdk
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

TWEAK_NAME = FakeOperator
FakeOperator_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk