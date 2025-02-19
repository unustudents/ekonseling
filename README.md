# Ekonseling

Generasi baru berkonsultasi

## Getting Started

## License
This project is licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

## Version Flutter
- Flutter version 3.27.1 on channel stable
- Dart version 3.6.0
- DevTools version 2.40.2

## Tambahkan
Tambahkan ke **android/app/src/main/Androidmanifest.xml** di dalam tag `<manifest ...>`
```xml
<!-- Internet permissions do not affect the `permission_handler` plugin, but are required if your app needs access to the internet. -->
<uses-permission android:name="android.permission.INTERNET"/>
<!-- Permissions options for the `storage` group -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<!-- Read storage permission for Android 12 and lower -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<!-- Granular media permissions for Android 13 and newer.
See https://developer.android.com/about/versions/13/behavior-changes-13#granular-media-permissions for more information. -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<!-- Permissions options for the `manage external storage` group -->
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
```
#
Ubah `com.android.application` didalam **andorid/settings.gradle** menjadi 8.2.1:
```gradle
plugins {
    id "com.android.application" version "8.2.1"
}
```
# 
Ubah `compileSdk` (minimal 34) di **android/app/build.gradle**
```gradle
android {
    ...
    compileSdk=34
}
```
# 
Tambahkan kode berikut di **android/app/build.gradle**
```gradle
buildTypes {
    release {
        ...
        minifyEnabled true, 
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```
#
Tambahkan di **android/gradle.properties**
```properties
org.gradle.parallel=true, 
org.gradle.caching=true
```
#
android:requestLegacyExternalStorage="true"