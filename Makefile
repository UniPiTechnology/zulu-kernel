

PHONY := __all
__all:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts

%:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx dtstree=../dts $@

%_defconfig:
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx KBUILD_DEFCONFIG=../../../../configs/$@ defconfig

clean:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx $@

mrproper:
	@find dts -name .\* -exec rm \{\} \;
	@find dts -name \*.dtb -exec rm \{\} \;
	MAKEFLAGS="$(MAKEFLAGS)" $(MAKE) -C linux-imx $@

scmversion:
	@ # create empty .scmversion to remove + sign from kernelrelease
	@ :> linux-imx/.scmversion
