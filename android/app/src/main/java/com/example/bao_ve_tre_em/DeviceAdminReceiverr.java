package com.example.bao_ve_tre_em;

import android.app.AlertDialog;
import android.app.admin.DeviceAdminReceiver;
import android.app.admin.DevicePolicyManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.text.InputType;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.Toast;

public class DeviceAdminReceiverr extends DeviceAdminReceiver {
    @Override
    public void onEnabled(Context context, Intent intent) {
        super.onEnabled(context, intent);
        Toast.makeText(context, "Device Admin: enabled", Toast.LENGTH_SHORT).show();
        SharedPreferences prf = context.getSharedPreferences("Permissions", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prf.edit();
        editor.putBoolean("DeviceAdmin", true);
        editor.apply();
    }

    @Override
    public void onDisabled(Context context, Intent intent) {
        super.onDisabled(context, intent);
        Toast.makeText(context, "Device Admin: disabled", Toast.LENGTH_SHORT).show();
        SharedPreferences prf = context.getSharedPreferences("Permissions", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prf.edit();
        editor.putBoolean("DeviceAdmin", false);
        editor.apply();
    }

    // Bắt sự kiện người dung tắt quyền device admin
    @Override
    public CharSequence onDisableRequested(Context context, Intent intent) {
//        AlertDialog.Builder builder = new AlertDialog.Builder(context);
//        builder.setTitle("Nhập mật khẩu");
//
//        final EditText passwordInput = new EditText(context);
//        passwordInput.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
//        builder.setView(passwordInput);
//
//        builder.setPositiveButton("Xác nhận", new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface dialog, int which) {
//                String enteredPassword = passwordInput.getText().toString();
//                if (enteredPassword.equals("12345678")) {
//                    DevicePolicyManager devicePolicyManager = (DevicePolicyManager) context.getSystemService(Context.DEVICE_POLICY_SERVICE);
//                    ComponentName compName = new ComponentName(context, DeviceAdminReceiverr.class);
//
//                    devicePolicyManager.removeActiveAdmin(compName);
//                    Toast.makeText(context, "Mật khẩu đúng! Quyền quản trị viên đã bị hủy.", Toast.LENGTH_SHORT).show();
//                } else {
//                    Toast.makeText(context, "Sai mật khẩu!", Toast.LENGTH_SHORT).show();
//                }
//            }
//        });
//
//        // Xử lý khi người dùng nhấn Hủy
//        builder.setNegativeButton("Hủy", new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface dialog, int which) {
//                dialog.cancel(); // Đóng dialog
//            }
//        });
//
//        // Hiển thị dialog
//        AlertDialog dialog = builder.create();
//        dialog.getWindow().setType(WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY); // Cần cấp quyền SYSTEM_ALERT_WINDOW
//        dialog.show();

        return "Bạn cần nhập mật khẩu để vô hiệu hóa quyền quản trị viên thiết bị.";
    }

}
