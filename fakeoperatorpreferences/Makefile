include theos/makefiles/common.mk

BUNDLE_NAME = FakeOperatorPreferences
FakeOperatorPreferences_FILES = FakeOperatorPreferences.mm
FakeOperatorPreferences_INSTALL_PATH = /Library/PreferenceBundles
FakeOperatorPreferences_FRAMEWORKS = UIKit
FakeOperatorPreferences_PRIVATE_FRAMEWORKS = Preferences

include theos/makefiles/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FakeOperatorPreferences.plist$(ECHO_END)
