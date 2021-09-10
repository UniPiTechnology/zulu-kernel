

PHONY := __all
__all:
	$(MAKE) -C linux-imx $(MAKEFLAGS) dtstree=../dts

%:
	$(MAKE) -C linux-imx $(MAKEFLAGS) dtstree=../dts $@

defconfig: unipi-zulu_defconfig
	$(MAKE) -C linux-imx $(MAKEFLAGS) KBUILD_DEFCONFIG=../../../../$^ defconfig

clean:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	$(MAKE) -C linux-imx $(MAKEFLAGS) $@

mrproper:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	$(MAKE) -C linux-imx $(MAKEFLAGS) $@
