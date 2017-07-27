# XFruitsMobile For iOS

### 拾个鲜果移动端Native源码(仅iOS平台)

### 使用

```
git clone https://git.coding.net/shuoit/XFruitsMobile.git

cd XFruits/

```

### 此过程比较耗时，建议耐心等待

```
carthage bootstrap
```
    
### 当需要增加或更新项目中第三方库的最新的编译版本时，请执行如下命令：

    carthage update Box

### 或者

    carthage update Box1 Box2

### 如果Carthage提示需要更新，执行
    brew upgrade carthage

### 如果有多个Xcode，请选择合适的Swift版本

    sudo xcode-select -switch /Applications/Xcode-beta.app

    swift --version
