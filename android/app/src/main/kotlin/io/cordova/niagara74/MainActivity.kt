package io.cordova.niagara74

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        try {
            val apiKey = getString(R.string.api_key)
            MapKitFactory.setApiKey(apiKey)
            MapKitFactory.setLocale("ru_RU")
        } catch (e: AssertionError) {}
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
