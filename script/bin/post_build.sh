echo post build action start...
echo checking apk contains debuggable flag by aapt
APK_NAME=$(cat ${WORKSPACE}/apkName.txt)
aapt l -a ${WORKSPACE}/app/build/outputs/apk/${APK_NAME} > ${WORKSPACE}/aapt.result

if grep -q "A: android:debuggable(0x0101000f)=(type 0x12)0xffffffff" aapt.result
then
    echo "(This is debug build apk. Do not publish)" > aapt_check_apk_result.html
else
    echo "(This is release build apk. It is good to publish)" > aapt_check_apk_result.html
fi

