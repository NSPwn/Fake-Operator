SBStatusBarCarrierView.h

%hook
-(id)_imageForOperatorName:(id)operatorName statusBarIsFullScreenOpaque:(BOOL)opaque;
%end

