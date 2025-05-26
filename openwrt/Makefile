include $(TOPDIR)/rules.mk

PKG_NAME:=engarde-client
PKG_VERSION:=0.20240802.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/porech/engarde.git
PKG_SOURCE_DATE:=2024-08-02
PKG_SOURCE_VERSION:=705f38a5dc5b565de949c060537066dc876d1985
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=Apache-2.0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=golang/host
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk
include ../../feeds/packages/lang/golang/golang-package.mk

GO_PKG:=github.com/porech/engarde
GO_PKG_BUILD_PKG:=github.com/porech/engarde/v2/cmd/engarde-client
GO_PKG_LDFLAGS:=-s -w
GO_PKG_DISABLE_CGO:=1

define Package/engarde-client
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Engarde tunneling
	URL:=$(GO_PKG)
endef

define Package/engarde-client/description
  A go network utility to create a reliable IP tunnel over multiple connections
endef

define Build/Compile
	mkdir -p $(PKG_BUILD_DIR)/.go_work/build
	cd $(PKG_BUILD_DIR)/webmanager && npm install && NODE_OPTIONS="--openssl-legacy-provider" npm run-script build-prod
	go install github.com/gobuffalo/packr/v2/packr2@latest
	$(call GoPackage/Build/Compile)
endef

define Package/engarde-client/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d
	$(INSTALL_BIN) ./engarde.init $(1)/etc/init.d/engarde-client
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/engarde-client $(1)/usr/bin/
endef

$(eval $(call BuildPackage,engarde-client))
