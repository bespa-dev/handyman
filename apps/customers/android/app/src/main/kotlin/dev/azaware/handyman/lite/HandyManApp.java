package dev.azaware.handyman.lite;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;

// Solves issue with white sc
public class HandyManApp extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
    }

    @Override
    public void registerWith(PluginRegistry pluginRegistry) {
    }
}
