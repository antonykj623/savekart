package com.integra.savekart

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.WindowInsetsController
import androidx.annotation.NonNull
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.native/redirect"
    private val REQUEST_CODE_WEB = 101

    var rslt:MethodChannel.Result?= null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val windowInsetsController = window.insetsController
            windowInsetsController?.systemBarsBehavior =
                WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE

            WindowCompat.setDecorFitsSystemWindows(window, false)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "goToNativeActivity") {
                    rslt=result;
                    val msg = call.argument<String>("msg") ?: "No message"
                    val i = Intent(this, WebNativeActivity::class.java)
                    i.putExtra("url", msg)
                    startActivityForResult(i, REQUEST_CODE_WEB)

                } else {
                    rslt=result;
                    result.notImplemented()
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_CODE_WEB && resultCode == Activity.RESULT_OK) {
            // You can handle data returned from WebNativeActivity here
            val resultData = data?.getStringExtra("result_url")
            rslt?.success(resultData.toString())
        // if you send back anything
        }
    }
}
