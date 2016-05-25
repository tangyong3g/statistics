# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in D:\androidsdk\sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:



# 代码混淆压缩比，在0~7之间，默认为5,一般不下需要修改
-optimizationpasses 5

# 混淆时不使用大小写混合，混淆后的类名为小写
# windows下的同学还是加入这个选项吧(windows大小写不敏感)
-dontusemixedcaseclassnames

# 指定不去忽略非公共的库的类
# 默认跳过，有些情况下编写的代码与类库中的类在同一个包下，并且持有包中内容的引用，此时就需要加入此条声明
-dontskipnonpubliclibraryclasses

# 指定不去忽略非公共的库的类的成员
-dontskipnonpubliclibraryclassmembers

# 不做预检验，preverify是proguard的四个步骤之一
# Android不需要preverify，去掉这一步可以加快混淆速度
-dontpreverify

# 有了verbose这句话，混淆后就会生成映射文件
# 包含有类名->混淆后类名的映射关系
# 然后使用printmapping指定映射文件的名称
-verbose
-printmapping priguardMapping.txt


# 指定混淆时采用的算法，后面的参数是一个过滤器
# 这个过滤器是谷歌推荐的算法，一般不改变
#-optimizations !code/simplification/artithmetic,!field/*,!class/merging/*

## 避免混淆泛型
## 这在JSON实体映射时非常重要，比如fastJson
-keepattributes Signature
#
## 保护代码中的Annotation不被混淆
## 这在JSON实体映射时非常重要，比如fastJson
-keepattributes *Annotation*
#
## 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

-keepclassmembers class * implements java.io.Serializable {*;}

# 保留所有的本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

## 保留Parcelable序列化的类不能被混淆
-keep class * implements android.os.Parcelable{
    public static final android.os.Parcelable$Creator *;
}

# 保留Serializable 序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
   static final long serialVersionUID;
   private static final java.io.ObjectStreamField[] serialPersistentFields;
   !static !transient <fields>;
   private void writeObject(java.io.ObjectOutputStream);
   private void readObject(java.io.ObjectInputStream);
   java.lang.Object writeReplace();
   java.lang.Object readResolve();
}

#-keepclassmembers class * implements java.io.Serializable {*;}


-keep class * implements java.io.Serializable {*;}


 #对R文件下的所有类及其方法，都不能被混淆
-keepclassmembers class **.R$* {
    *;
}

## 对于带有回调函数onXXEvent的，不能混淆
-keepclassmembers class * {
    void *(**On*Event);
}

-dontshrink

#
#-keep public class * {
#    public protected <fields>;
#    public protected <methods>;
#}

#-keep class com.tcl.statisticsdk.bean.**{ *;}

#
#
## 保留了继承自Activity、Application这些类的子类
## 因为这些子类有可能被外部调用
## 比如第一行就保证了所有Activity的子类不要被混淆
##-keep public class * extends android.app.Activity
##-keep public class * extends android.app.Application
##-keep public class * extends android.app.Service
##-keep public class * extends android.content.BroadcastReceiver
##-keep public class * extends android.content.ContentProvider
##-keep public class * extends android.app.backup.BackupAgentHelper
##-keep public class * extends android.preference.Preference
##-keep public class * extends android.view.View
##-keep public class com.android.vending.licensing.ILicensingService
#
#
#
## If your project uses WebView with JS, uncomment the following
## and specify the fully qualified class name to the JavaScript interface
## class:
##-keepclassmembers class fqcn.of.javascript.interface.for.webview {
##   public *;
##}
##
#

#-injars  build/intermediates/classes/release
#-injars  libs
#-outjars bin/statistics_sdk.jar