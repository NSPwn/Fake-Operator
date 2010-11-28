SDKVERSION = 3.0
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

SUBPROJECTS = fakeoperatorpreferences
TWEAK_NAME = FakeOperator
FakeOperator_FILES = Tweak.xm

include theos/makefiles/tweak.mk
include theos/makefiles/aggregate.mk
