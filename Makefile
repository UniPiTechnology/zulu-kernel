

PHONY := __all
__all:
	echo "__all"
	echo $(MAKEFLAGS)
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts

%:
	echo "__" $@ "__"
	echo $(MAKEFLAGS)
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts $@

%_defconfig:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx KBUILD_DEFCONFIG=../../../../$^ defconfig

clean:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx $@

mrproper:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx $@
