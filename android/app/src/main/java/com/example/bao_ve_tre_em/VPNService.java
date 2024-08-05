package com.example.bao_ve_tre_em;

import android.content.Intent;
import android.net.VpnService;
import android.os.ParcelFileDescriptor;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;

import io.flutter.Log;

public class VPNService extends VpnService {
    private Thread thread;
    private ParcelFileDescriptor vpnInterface;

    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (thread != null) {
            thread.interrupt();
        }

        thread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    runVpn();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });

        thread.start();
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        if (thread != null) {
            thread.interrupt();
        }
        if (vpnInterface != null) {
            try {
                vpnInterface.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        super.onDestroy();
    }

    private void runVpn() throws IOException {
        Builder builder = new Builder();
        builder.setMtu(1500);
        builder.addAddress("10.0.0.2", 24);
        builder.addRoute("0.0.0.0", 0);
        builder.addDnsServer("185.228.168.168");
        builder.addDnsServer("185.228.169.168");
        builder.addDnsServer("2a0d:2a00:1::");
        builder.addDnsServer("2a0d:2a00:2::");

        vpnInterface = builder.establish();

        FileInputStream in = new FileInputStream(vpnInterface.getFileDescriptor());
        FileOutputStream out = new FileOutputStream(vpnInterface.getFileDescriptor());

        ByteBuffer packet = ByteBuffer.allocate(32767);
        int length;
        while (true) {
            length = in.read(packet.array());
            if (length > 0) {
                packet.limit(length);
//                Log.d("Vpnnnnn", "Packet received: " + new String(packet.array(), 0, length));                out.write(packet.array(), 0, length);
                logPacket(packet,length);
                packet.clear();
            }
        }
    }
    private void logPacket(ByteBuffer packet, int length) {
        StringBuilder hexString = new StringBuilder();
        for (int i = 0; i < length; i++) {
            hexString.append(String.format("%02x ", packet.get(i)));
        }
            Log.d("Vpnnnnn", "Packet received: "+ hexString.toString());
    }


}
