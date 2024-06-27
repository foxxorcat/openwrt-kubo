include $(TOPDIR)/rules.mk

PKG_NAME:=kubo
PKG_URL:=https://github.com/ipfs/kubo
PKG_VERSION:=0.29.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/ipfs/kubo/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=7679ed1b2c6a713b2297ab025d83a50c17fbcebf7e3af3b92be06cb9678a40f5

# PKG_SOURCE_PROTO:=git
# PKG_SOURCE_URL:=https://github.com/ipfs/kubo
PKG_SOURCE_VERSION:=3f0947b74e3b5abbce25ac910a01de6268b7dd8e
# PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
# PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_LICENSE:=MIT
PKG_LICENSE_FILE:=LICENSE
PKG_MAINTAINER:=foxxorcat <foxxorcat@foxmail.com>

PKG_CONFIG_DEPENDS:= \
	CONFIG_KUBO_COMPRESS_UPX

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_DEPENDS += KUBO_COMPRESS_UPX:upx/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0 # https://github.com/openwrt/packages/issues/8498
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/ipfs/kubo
GO_PKG_BUILD_PKG:=$(GO_PKG)/cmd/ipfs
GO_PKG_LDFLAGS:= \
	-s -w \
	-X '$(GO_PKG).CurrentCommit=$(shell echo $(PKG_SOURCE_VERSION) | cut -c 1-9)'

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/$(PKG_NAME)
  	SECTION:=net
  	CATEGORY:=Network
	TITLE:=An IPFS implementation in Go
	URL:=https://ipfs.tech/
	DEPENDS:=$(GO_ARCH_DEPENDS) 
endef

define Package/$(PKG_NAME)/description
  Kubo was the first IPFS implementation and is the most widely used one today. 
  Implementing the Interplanetary Filesystem - the Web3 standard for content-addressing, 
  interoperable with HTTP. Thus powered by IPLD's data models and the libp2p for network communication. 
  Kubo is written in Go.
endef

define Package/$(PKG_NAME)/conffiles
/etc/kubo
/etc/config/kubo
endef

define Package/$(PKG_NAME)/config
	config KUBO_COMPRESS_UPX
		bool "Compress executable files with UPX"
		default n
endef

# 同时启用STRIP和upx会导致未知错误
ifeq ($(CONFIG_KUBO_COMPRESS_UPX),y)
    STRIP:=true
    GO_PKG_LDFLAGS += -s -w
endif

define Build/Compile
	$(call GoPackage/Build/Compile)
ifeq ($(CONFIG_KUBO_COMPRESS_UPX),y)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/ipfs
endif
endef

define Package/$(PKG_NAME)/install
	# echo "++++++++++++++++++"
	# echo "$(PKG_INSTALL_DIR)"
	# echo "$(1)"
	# echo "$(GO_PKG_BUILD_BIN_DIR)"
	# echo "++++++++++++++++++"
	$(call GoPackage/Package/Install/Bin,$(1))
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d $(1)/etc/kubo
	$(INSTALL_CONF) $(CURDIR)/files/kubo.config $(1)/etc/config/kubo
	$(INSTALL_BIN) $(CURDIR)/files/kubo.init $(1)/etc/init.d/kubo
endef

$(eval $(call BuildPackage,$(PKG_NAME)))