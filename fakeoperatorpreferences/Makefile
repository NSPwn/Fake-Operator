include theos/makefiles/common.mk

BUNDLE_NAME = FakeOperatorPreferences
FakeOperatorPreferences_FILES = FakeOperatorPreferences.mm
FakeOperatorPreferences_INSTALL_PATH = /Library/PreferenceBundles
FakeOperatorPreferences_PRIVATE_FRAMEWORKS = Preferences

include theos/makefiles/bundle.mk

after-FakeOperatorPreferences-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences
	cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FakeOperatorPreferences.plist
