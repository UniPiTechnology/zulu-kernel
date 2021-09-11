

PHONY := __all
__all:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts

%:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts $@

PHONY := unipi-zulu_defconfig
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
