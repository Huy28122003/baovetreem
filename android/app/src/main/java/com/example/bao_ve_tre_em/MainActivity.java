package com.example.bao_ve_tre_em;

import android.accessibilityservice.AccessibilityServiceInfo;
import android.app.admin.DevicePolicyManager;
import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.accessibility.AccessibilityManager;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
//    private static final String CHANNEL = "vpn";
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            if (call.method.equals("startVpn")) {
//                                startVpn();
//                                result.success("VPN started");
//                            } else if (call.method.equals("stopVpn")) {
//                                stopVpn();
//                                result.success("VPN stopped");
//                            } else {
//                                result.notImplemented();
//                            }
//                        }
//                );
//    }
//
//    private void startVpn() {
//        Intent intent = VpnService.prepare(this);
//        if (intent != null) {
//            startActivityForResult(intent, 0);
//        } else {
//            startService(new Intent(this, VPNService.class).setAction("START"));
//        }
//    }
//
//    private void stopVpn() {
//        startService(new Intent(this, VPNService.class).setAction("STOP"));
//    }

//    @Override
//    public void configureFlutterEngine(FlutterEngine flutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//        flutterEngine.getPlugins().add(new OpenDeviceAdminPlugin());
//    }

    private static final int REQUEST_CODE = 123;
    private DevicePolicyManager devicePolicyManager;
    private ComponentName adminComponent;
    private static final String CHANNEL = "OpenDeviceAdminSetting";

    private void requestEnableDeviceAdmin() {
        devicePolicyManager = (DevicePolicyManager) getSystemService(Context.DEVICE_POLICY_SERVICE);
        adminComponent = new ComponentName(this, DeviceAdminReceiverr.class);
        if (!devicePolicyManager.isAdminActive(adminComponent)) {
            Intent intent = new Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN);
            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, adminComponent);
            intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, "Ứng dụng cần quyền để thực hiện các chức năng quản lý thiết bị.");
            startActivityForResult(intent, REQUEST_CODE);
        } else {
            Log.d("Device Admin","Đã có quyền này");
        }
    }

    private boolean checkPermission(){
        devicePolicyManager = (DevicePolicyManager) getSystemService(Context.DEVICE_POLICY_SERVICE);
        adminComponent = new ComponentName(this, DeviceAdminReceiverr.class);
        if (!devicePolicyManager.isAdminActive(adminComponent)) {
            return false;
        } else {
            return true;
        }
    }
    private boolean checkUsageStatsPermission() {
        UsageStatsManager usageStatsManager = (UsageStatsManager) getSystemService(Context.USAGE_STATS_SERVICE);
        long currentTime = System.currentTimeMillis();
        // Kiểm tra xem quyền đã được cấp bằng cách truy vấn thống kê sử dụng
        if (usageStatsManager != null) {
            // Lấy thống kê sử dụng cuối cùng trong vòng 24 giờ qua
            List<UsageStats> usageStatsList = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, currentTime - 1000 * 60 * 60 * 24, currentTime);
            return usageStatsList != null && !usageStatsList.isEmpty();
        }
        return false;
    }

    private boolean checkAccessibilityServicePermission(String serviceName) {
        AccessibilityManager am = (AccessibilityManager) getSystemService(Context.ACCESSIBILITY_SERVICE);
        List<AccessibilityServiceInfo> enabledServices = am.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK);

        for (AccessibilityServiceInfo service : enabledServices) {
            if (service.getId().equals(serviceName)) {
                return true;}
        }
        return false;
    }
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
//        super.onActivityResult(requestCode, resultCode, data);
//        if (requestCode == REQUEST_CODE) {
//            boolean isAdminActive = devicePolicyManager.isAdminActive(adminComponent);
//            if (isAdminActive) {
//            } else {
//            }
//        }
//    }

    @Override
            public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("requestDeviceAdmin")) {
                        requestEnableDeviceAdmin();
                        result.success(null);
                    } else if (call.method.equals("checkDeviceAdminStatus")) {
                        result.success(checkPermission());
                    }else if (call.method.equals("checkUsageStatsPermission")) {
                        result.success(checkUsageStatsPermission());
                    }else if (call.method.equals("checkAccessibilityServicePermission")) {
                        result.success(checkAccessibilityServicePermission("com.example.bao_ve_tre_em/.AccessibilityServicee"));
                    }
                });
    }

}
