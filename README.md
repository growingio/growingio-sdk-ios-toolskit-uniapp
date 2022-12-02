![GrowingIO](https://www.growingio.com/vassets/images/home_v3/gio-logo-primary.svg)  

[![SDK Team Name](https://img.shields.io/badge/Team-SDK-orange.svg?style=flat)](https://github.com/growingio "SDK Team") [![Platform iOS](https://img.shields.io/badge/platform-iOS-brightgreen)]() [![License](https://img.shields.io/github/license/growingio/growingio-sdk-ios-toolskit)](https://github.com/growingio/growingio-sdk-ios-toolskit/blob/master/LICENSE)




## GrowingToolsKit for uniapp

GrowingToolsKit 旨在帮助用户提高集成 GrowingIO SDK 效率，在使用 SDK 的开发过程中，便于排查问题，为用户提供最好的埋点服务。

源码地址：https://github.com/growingio/growingio-sdk-ios-toolskit

本插件为 GrowingToolsKit 原生 SDK lite 版本，去除了 uni-app 平台下不需要的部分功能

### 集成

Release 目录下为已打包好的 GrowingToolsKit 原生插件 (GrowingToolsKit-SDK2nd 为适配 uni-app 埋点 SDK 2.x 打包)，可直接用来离线打包或云打包

GrowingToolsKit 原生插件默认自动随着应用启动而初始化

在 HBuilderX 中集成后，可配置 `growing_ios_giokit_delay_init` 来实现延迟初始化（在 uni-app 应用适当时机初始化），代码如下：

```vue
var giokit = uni.requireNativePlugin("GrowingToolsKit")
// 初始化 giokit
giokit.start()

// 获取 giokit 版本
var ret = giokit.version()
uni.showToast({
  title:'GrowingToolsKit Version: ' + ret,
  icon: "none"
})
```



### 开发调试

1. 手动下载 GrowingCoreKit 2.9.13 (大概 30MB)，并放入 `HBuilder-uniPluginDemo`

2. 自行下载 uni-app 开发插件需要的 [SDK 包](https://nativesupport.dcloud.net.cn/AppDocs/download/ios) (开发时用的是 3.6.5，大概 1GB) 并解压，将解压后的 `SDK/SDK` 目录放在根目录下

3. 运行项目中 `HBuilder-uniPluginDemo/HBuilder-uniPlugin.xcodeproj` 进行开发调试，其已集成好 [uni-app 埋点 SDK 2.x](https://github.com/growingio/growing-sdk-uniapp)，后续再添加 uni-app 埋点 SDK 3.x 集成

4. 编译时，Build Settings 修改 **GCC_PREPROCESSOR_DEFINITIONS** 添加 `GROWING_SDK2nd=1`，将适配 uni-app 埋点 SDK 2.x，否则 GioKit 内部分 SDK 信息将显示错误

5. 编译产物 GrowingToolsKit.framework 替换掉 Release 目录下对应的插件目录下 `ios/GrowingToolsKit.framework`，根据是否修改 **GCC_PREPROCESSOR_DEFINITIONS** 来选择对应插件

   ```
   .
   ├── GrowingToolsKit
   │   ├── ios
   │   │   ├── BundleResources
   │   │   │   └── GrowingToolsKit.bundle
   │   │   └── GrowingToolsKit.framework
   │   └── package.json
   └── GrowingToolsKit-SDK2nd
       ├── ios
       │   ├── BundleResources
       │   │   └── GrowingToolsKit.bundle
       │   └── GrowingToolsKit.framework // GCC_PREPROCESSOR_DEFINITIONS 添加 GROWING_SDK2nd=1
       └── package.json
   ```

uni-app 应用中的主要代码如下：

```vue
<template>
	<div>
		<button type="primary" @click="start">start</button>
		<button type="primary" @click="startWithPosition">startWithPosition</button>
		<button type="primary" @click="version">version</button>
	</div>
</template>

<script>
	var giokit = uni.requireNativePlugin("GrowingToolsKit")
	export default {
		methods: {
			start() {
				giokit.start()
			},
			startWithPosition() {
				giokit.startWithPosition({ "x" : 100, "y" : 200}, false)
			},
			version() {
				var ret = giokit.version()
				uni.showToast({
					title:'GrowingToolsKit Version: ' + ret,
					icon: "none"
				})
			}
		}
	}
</script>
```



## License

All source code is licensed under the LICENSE-2.0 license. See [LICENSE](https://github.com/growingio/growingio-sdk-ios-toolskit/blob/master/LICENSE) for details.