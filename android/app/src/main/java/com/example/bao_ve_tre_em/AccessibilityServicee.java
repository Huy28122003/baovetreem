package com.example.bao_ve_tre_em;

import android.accessibilityservice.AccessibilityService;
import android.content.Intent;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;

public class AccessibilityServicee extends AccessibilityService {

    private static final String TAG = "AccessibilityService";
    private static final String BLOCKED_APP_PACKAGE_NAME = "com.example.musicc";

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {

        if (event == null || event.getPackageName() == null) {
            return;
        }
        // Lấy tên gói của ứng dụng đang chạy
        String currentPackageName = event.getPackageName().toString();
        Log.d(TAG, "Current package: " + currentPackageName);

        // Kiểm tra xem ứng dụng hiện tại có phải là ứng dụng bị chặn không
        if (currentPackageName.equals(BLOCKED_APP_PACKAGE_NAME)) {
            // Nếu đúng, quay lại màn hình chính
            Log.d(TAG, "Blocked app detected, returning to home screen.");

            Intent startMain = new Intent(Intent.ACTION_MAIN);
            startMain.addCategory(Intent.CATEGORY_HOME);
            startMain.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(startMain);
        }
    }

    @Override
    public void onInterrupt() {

    }
}
