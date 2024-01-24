# ysPlay

Flutter Ys7 (YingShi Cloud) Live Streaming Plugin, supporting Android and IOS.

## Features
1. Account integration (authorization login).
2. Live streaming (supports setting streaming resolution).
3. Playback.
4. Live streaming and playback with simultaneous recording.
5. Live streaming and playback with simultaneous screenshot capture.
6. PTZ (Pan-Tilt-Zoom) control.
7. Device configuration.
8. Intercom (includes half-duplex and full-duplex intercom).

## Preparation
Before integration, it's recommended to read the [official documentation](http://open.ezvizlife.com/help/36).

## Installation
Add the following dependency to your `pubspec.yaml` file:
```yaml
dependencies: 
    ys_play: ^0.0.6
```

## Project Configuration
### Android
In the `AndroidManifest.xml` file, add the following permissions:
```xml 
<!-- Basic permissions required for core functionality -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<!-- Permissions required for device configuration -->
<!-- ... -->
<!-- Permissions required for accessing local media -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<!-- Network location permission -->
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<!-- Microphone permissions-->
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS"/>
<!-- ... -->

```       

Add the following configurations to the app-level `build.gradle` file:
```gradle
android {
    ...
    defaultConfig {
        ...
        ndk {
            abiFilters "armeabi-v7a", "arm64-v8a"
        }
    }

    sourceSets {
        main {
            jniLibs.srcDirs = ['libs']
        }
    }
}
```
Apply the following code obfuscation rules in your ProGuard configuration file:
```proguard
    # SDK external interfaces
    -keep class com.ezviz.opensdk.** { *;}

    #========Hikvision libraries=======#
    -dontwarn com.ezviz.**
    -keep class com.ezviz.** { *;}

    -dontwarn com.ez.**
    -keep class com.ez.** { *;}

    -dontwarn com.hc.CASClient.**
    -keep class com.hc.CASClient.** { *;}

    -dontwarn com.videogo.**
    -keep class com.videogo.** { *;}

    -dontwarn com.hik.TTSClient.**
    -keep class com.hik.TTSClient.** { *;}

    -dontwarn com.hik.stunclient.**
    -keep class com.hik.stunclient.** { *;}

    -dontwarn com.hik.streamclient.**
    -keep class com.hik.streamclient.** { *;}

    -dontwarn com.hikvision.sadp.**
    -keep class com.hikvision.sadp.** { *;}

    -dontwarn com.hikvision.netsdk.**
    -keep class com.hikvision.netsdk.** { *;}

    -dontwarn com.neutral.netsdk.**
    -keep class com.neutral.netsdk.** { *;}

    -dontwarn com.hikvision.audio.**
    -keep class com.hikvision.audio.** { *;}

    -dontwarn com.mediaplayer.audio.**
    -keep class com.mediaplayer.audio.** { *;}

    -dontwarn com.hikvision.wifi.**
    -keep class com.hikvision.wifi.** { *;}

    -dontwarn com.hikvision.keyprotect.**
    -keep class com.hikvision.keyprotect.** { *;}

    -dontwarn com.hikvision.audio.**
    -keep class com.hikvision.audio.** { *;}

    -dontwarn org.MediaPlayer.PlayM4.**
    -keep class org.MediaPlayer.PlayM4.** { *;}
    #========Add your Hikvision library rules here=======#

    #========Third-party open-source libraries=======#
    # JNA
    -dontwarn com.sun.jna.**
    -keep class com.sun.jna.** { *;}

    # Gson
    -keepattributes *Annotation*
    -keep class sun.misc.Unsafe { *; }
    -keep class com.idea.fifaalarmclock.entity.***
    -keep class com.google.gson.stream.** { *; }

    # OkHttp
    # JSR 305 annotations are for embedding nullability information.
    -dontwarn javax.annotation.**
    # A resource is loaded with a relative path so the package of this class must be preserved.
    -keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
    # Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
    -dontwarn org.codehaus.mojo.animal_sniffer.*
    # OkHttp platform used only on JVM and when Conscrypt dependency is available.
    -dontwarn okhttp3.internal.platform.ConscryptPlatform
    # 必须额外加的，否则编译无法通过
    -dontwarn okio.**
    #========以上是第三方开源库=======#
```

### IOS Configuration
## Add the following entries to the Info.plist file:

1.Album permissions: If you need to use the open platform player to record and take screenshots and save them, you need to configure the album permissions. 
```plist
<!-- Photo library permissions -->
<key>NSPhotoLibraryAddUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to the photo library</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to the photo library</string>

<!-- Microphone permissions -->
<key>NSMicrophoneUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to the microphone</string>

<!-- Camera permissions -->
<key>NSCameraUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to the camera</string>

<!-- Network permissions for device configuration -->
<key>NSLocalNetworkUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to local network for Wi-Fi configuration</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to location for Wi-Fi configuration</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to location for Wi-Fi configuration</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>$(PRODUCT_NAME) needs access to location for Wi-Fi configuration</string>
```

## Configure in xcode
In Xcode, navigate to Runner -> Target -> Target-Signing & Capabilities and add the following capabilities:
Access WiFi Information (for obtaining the connected WiFi name, required for device configuration).
Hotspot Configuration (for connecting to specified WiFi, required for device configuration).
Note: Both capabilities also need to be added to the App Store certificate.
	




