adb connect 192.168.1.62:12145
adb devices
adb disconnect
adb pair 192.168.1.62:12437
adb shell
adb shell input keyevent 24
adb shell input keyevent 25
adb shell input text "coucou%sbeu"
adb shell ls -l /storage/emulated/0
adb shell pm uninstall --user 0 com.google.chrome # safe ?
adb shell pm uninstall --user 0 com.android.chrome # safe ?
