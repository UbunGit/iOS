# iOS

## 文件结构
```
UGOCMagicbox //主文件
     |- Config 项目配置
     |- category 常用的分类
     |- Components 常用的工具类
     |- Magic 常用功能
     |- View 常用业务
     |— DoraemonKit 测试工具
```

- [第一篇 项目配置](#第一篇)
    - [颜色](#颜色)
    - [字体](#字体)
    - [常量](#常量)
- [第二篇 常用的分类](#第二篇)
    - [NSObject](#NSObject)
    - [UIView](#UIView)
    - [UIControl](#UIControl)
    - [UIImage](#UIImage)
    - [UILable](#UILable)
    - [UIButton](#UIButton)
    - [UIColor](#UIColor)
    - [UITextView](#UITextView)
    - [UITextField](#UITextField)
    - [NSString](#NSString)
- [第三篇 常用的工具类](#第三篇)
    - [骨架加载TABAnimated](#骨架加载TABAnimated)
    - [导航栏RTRootNavigationController](#导航栏RTRootNavigationController)
    - [NIMSDK](#NIMSDK)
    - [日志CocoaLumberjack](#日志CocoaLumberjack)
    - [TabBar](#TabBar)
    - [图片选择TZImagePickController](#图片选择TZImagePickController)
    - [通讯录PPGetAddressBook](#通讯录PPGetAddressBook)
    - [弹框MBProgressHUD](#弹框MBProgressHUD)
    - [腾讯播放器SuperPlay](#腾讯播放器SuperPlay)
- [第四篇 常用功能](#第四篇)
    - [MAP高德地图](#MAP高德地图)
    - [菜单列表BarcollectionView](#菜单列表BarcollectionView)
    - [BlockTableview](#BlockTableview)
    - [BlockCollectionView](#BlockCollectionView)
    - [欢迎页面Welcom](#欢迎页面Welcom)

- [第五篇 测试工具](#第五篇)
- [第六篇 常用第三方框架](#第六篇)


## 第一篇 项目配置

### 颜色
### 字体
### 常量

## 第二篇 常用的分类

### NSObject

### UIView
```  
UG.h
/**
 * 设置圆角
 */
- (void)setCornerRadius:(CGFloat)radius;
```

```
alert.h
//提示文字
+(void)ug_msg:(NSString*)msg;
-(void)ug_msg:(NSString*)msg;

//提示文字 结束后调用block
+(void)ug_msg:(NSString*)msg complete:(nullable AlertViewFinesh)block;
-(void)ug_msg:(NSString*)msg complete:(nullable AlertViewFinesh)block;

//提示图片
+(void)ug_alertimageType:(NSString*)imagestr;
-(void)ug_alertimageType:(NSString*)imagestr;

//提示图片 结束后调用block
+(void)ug_alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;
-(void)ug_alertimageType:(NSString*)imagestr complete:(nullable AlertViewFinesh)block;

//弹出给定的view，自带取消按钮
+(void)ug_alertview:(UIView*)aview;
-(void)ug_alertview:(UIView*)aview;

//弹出给定的view，自带取消按钮 结束后调用block
+(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;
-(void)ug_alertview:(UIView*)aview complete:(nullable AlertViewFinesh)block;

// loading框
+(void)ug_starloading;
-(void)ug_starloading;

+(void)ug_stoploading;
-(void)ug_stoploading;
```
### UIControl
```
@property (nonatomic, assign) NSTimeInterval ug_eventInterval;//button 点击间隔时间

/**
 * 添加 block 事件
 */
-(void)ug_addEvents:(UIControlEvents)event andBlock:(ug_ButtonActionBlock)block;

/**
 * 添加 block 事件
 * eventInterval 点击间隔时间内不能响应
 */
-(void)ug_addEvents:(UIControlEvents)event eventInterval:(NSTimeInterval)eventInterval andBlock:(ug_ButtonActionBlock)block;

```
### UIImage
```
//根据给定颜色返回图片
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 根据给定CGSize 返回图片
 * return 改变尺寸后的图
 */
- (UIImage *)reSize:(CGSize)reSize;
```
### UILable
```
/**
 * 设置lable字体跟颜色
 */
-(void)setFont:(UIFont *)font Color:(UIColor*)color;
```
### UIButton
```
/**
 * button 图片赋值/图片名称必须规范
 *  imagestr_Normal
 *  imagestr_Highlighted
 *  imagestr_Disabled
 *  imagestr_Selected
 *  imagestr_Focused
 *  imagestr_Application
 *  imagestr_Reserved
 */
-(void)ug_setImage:(NSString *)imagestr;
```
### UIColor
```
/**
 * rgb色值 255
 */
+ (UIColor*)ug_R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

/**
 * 16进制色值 #232323
 */
+ (UIColor *)ug_hexString:(NSString *)color;

/**
 * 随机色
 */
+ (UIColor*)ug_random;
```
### UITextView
```
/**
 *  文本最大支持多少个字符，设置后会自动根据该属性截取文本字符长度
 */
@property (nonatomic, assign) NSInteger ug_maximumLimit;

/**
 *  文本发生改变时回调
 */
- (void)ug_textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码
 */
- (void)ug_fixMessyDisplay;

```
### UITextField
### NSString
```
/**
 *  URLEncode
 */
- (NSString *)ug_urlencodedString;

/**
 *  URLDecode
 */
-(NSString *)ug_urldecodedString;

/**
 * md5
 */
-(NSString *)md5;
```

## 第三篇 常用的工具类

### 骨架加载TABAnimated
### 导航栏RTRootNavigationController
### NIMSDK
### 日志CocoaLumberjack
### TabBar
### 图片选择TZImagePickController
### 通讯录PPGetAddressBook
### 弹框MBProgressHUD
### 腾讯播放器SuperPlay

## 第四篇 常用功能

### MAP高德地图
 > BlockMAMapView 将高德地图的MAMapView的delegate修改为Block方式
### 菜单列表BarcollectionView
### BlockTableview
>  BlockTableview 将UITableView的delegate修改为Block方式
### BlockCollectionView
>  BlockCollectionView 将UITableView的delegate修改为Block方式
### 欢迎页面Welcom

## 第五篇 测试工具

## 第六篇 常用第三方框架
