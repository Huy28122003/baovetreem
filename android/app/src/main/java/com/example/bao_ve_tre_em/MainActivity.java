package com.example.bao_ve_tre_em;
import android.app.Service;
import android.content.*;
import android.content.Intent;
import android.net.VpnService;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "vpn";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startVpn")) {
                                startVpn();
                                result.success("VPN started");
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
    private void startVpn() {
        Intent intent = VpnService.prepare(this);
        if (intent != null) {
            startActivityForResult(intent, 0);
        } else {
            startService(new Intent(this, VPNService.class));
        }
    }
}



