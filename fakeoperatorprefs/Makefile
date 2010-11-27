SYSROOT = /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.2.sdk
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

BUNDLE_NAME = FakeOperatorPrefs
FakeOperatorPrefs_FILES = FakeOperatorPrefs.mm
FakeOperatorPrefs_INSTALL_PATH = /Library/PreferenceBundles
FakeOperatorPrefs_FRAMEWORKS = UIKit
FakeOperatorPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FakeOperatorPrefs.plist$(ECHO_END)
