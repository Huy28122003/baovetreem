package com.example.bao_ve_tre_em;

import android.annotation.SuppressLint;
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
        if ("START".equals(intent.getAction())) {
            startVpn();
        } else if ("STOP".equals(intent.getAction())) {
            stopVpn();
        }
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        stopVpn();
        super.onDestroy();
    }

    private void startVpn() {
        if (thread != null) {
            thread.interrupt();
        }

        thread = new Thread(() -> {
            try {
                runVpn();
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

        thread.start();
    }

    private void stopVpn() {
        if (thread != null) {
            thread.interrupt();
        }
        if (vpnInterface != null) {
            try {
                vpnInterface.close();
                vpnInterface = null;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        stopSelf();
    }

    private void runVpn() throws IOException {
        Builder builder = new Builder();
        builder.setMtu(1500);
        builder.addAddress("10.0.0.2", 24);
        builder.addRoute("0.0.0.0", 0);
//        builder.addDnsServer("8.8.8.8");
        builder.addDnsServer("185.228.168.168");
        builder.addDnsServer("185.228.169.168");
        builder.addDnsServer("2a0d:2a00:1::");
        builder.addDnsServer("2a0d:2a00:2::");
        vpnInterface = builder.establish();
        if (vpnInterface == null) {
            throw new IOException("Failed to establish VPN interface");
        }

        FileInputStream in = new FileInputStream(vpnInterface.getFileDescriptor());
        FileOutputStream out = new FileOutputStream(vpnInterface.getFileDescriptor());

        ByteBuffer packet = ByteBuffer.allocate(32767);
        int length;
        try {
            while (!Thread.currentThread().isInterrupted()) {
                length = in.read(packet.array());
                if (length > 0) {
                    packet.limit(length);
                    String packetData = processPacket(packet);
                    if (packetData != null && !packetData.contains("185.228.169.168") && !packetData.contains("185.228.168.168")) {
                        Log.d("VpnService", "Packet received: " + packetData);
                    }

                    out.write(packet.array(), 0, length);
                    packet.clear();
                }
            }
        } catch (IOException e) {
            Log.e("VpnService", "IOException in runVpn", e);
        } finally {
            try {
                in.close();
                out.close();
            } catch (IOException e) {
                Log.e("VpnService", "IOException in runVpn (closing streams)", e);
            }
        }
    }

    private String processPacket(ByteBuffer packet) {
        packet.position(0);
        byte[] ipHeader = new byte[20]; // IPv4 header length
        packet.get(ipHeader);

        @SuppressLint("DefaultLocale") String sourceIp = String.format("%d.%d.%d.%d", ipHeader[12] & 0xFF, ipHeader[13] & 0xFF, ipHeader[14] & 0xFF, ipHeader[15] & 0xFF);
        @SuppressLint("DefaultLocale") String destinationIp = String.format("%d.%d.%d.%d", ipHeader[16] & 0xFF, ipHeader[17] & 0xFF, ipHeader[18] & 0xFF, ipHeader[19] & 0xFF);

        byte[] payload = new byte[packet.remaining()];
        packet.get(payload);
        String payloadData = new String(payload);

        return String.format("Source IP: %s, Destination IP: %s", sourceIp, destinationIp);
    }

}
