package com.example.niagara_app

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        try {
            val apiKey = getString(R.string.api_key)
            MapKitFactory.setApiKey(apiKey)
        } catch (e: AssertionError) {}
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
