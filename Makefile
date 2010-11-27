SYSROOT = /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.2.sdk

include theos/makefiles/common.mk

TWEAK_NAME = FakeOperator
FakeOperator_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk


after-FakeOperator-package::
	$(FAKEROOT) cp -R layout/* _/