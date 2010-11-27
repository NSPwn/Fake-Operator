SDKVERSION = 4.2
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

BUNDLE_NAME = FakeOperatorPrefs
FakeOperatorPrefs_FILES = FakeOperatorPrefs.mm
FakeOperatorPrefs_INSTALL_PATH = /Library/PreferenceBundles
FakeOperatorPrefs_FRAMEWORKS = UIKit
FakeOperatorPrefs_PRIVATE_FRAMEWORKS = Preferences

include theos/makefiles/bundle.mk
include theos/makefiles/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FakeOperatorPrefs.plist$(ECHO_END)
