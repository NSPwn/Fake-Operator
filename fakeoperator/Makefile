SDKVERSION = 4.2
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

SUBPROJECTS = FakeOperatorPrefs
TWEAK_NAME = FakeOperator
FakeOperator_FILES = Tweak.xm

include theos/makefiles/tweak.mk
include theos/makefiles/aggregate.mk

copy:: stage
	make -C ../fakeoperatorprefs clean; make -C ../fakeoperatorprefs; make -C ../fakeoperatorprefs install;
	rm -rf layout/Library
	cp -R ../fakeoperatorprefs/_/* layout
