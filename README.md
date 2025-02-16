# Ekonseling

Generasi baru berkonsultasi

## Getting Started

## License
This project is licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

## Version Flutter
- Flutter version 3.27.1 on channel stable
- Dart version 3.6.0
- DevTools version 2.40.2

## tambahkan
Tambahkan ke android/app/src/main/Androidmanifest.xml di dalam tag <manifest ...>
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
```gradle
# ubah com.android.application di andorid/settings.gradle
{
    id "com.android.application" version "8.2.1"
}

# ubah compileSdk (minimal 34) di android/app/build.gradle
android{
    ...
    compileSdk=34
}

android:requestLegacyExternalStorage="true"
tambahkan [minifyEnabled true, proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'] di android/app/build.gradle pada bagian buildTypes/release
tambahkan [org.gradle.parallel=true, org.gradle.caching=true] di android/gradle.properties
```