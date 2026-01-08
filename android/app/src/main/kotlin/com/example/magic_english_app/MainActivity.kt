package com.example.magic_english_app

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.magicenglish/process_text"
    private var sharedText: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Tạo kênh liên lạc với Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSharedText") {
                // Flutter hỏi: "Có văn bản nào được share không?"
                result.success(sharedText)
                sharedText = null // Lấy xong thì xóa đi để không bị trùng lặp
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_PROCESS_TEXT == action && type != null) {
            if ("text/plain" == type) {
                // Lấy văn bản được bôi đen
                sharedText = intent.getStringExtra(Intent.EXTRA_PROCESS_TEXT) ?: ""

                // Nếu văn bản có nội dung, cập nhật lại view
                if (!sharedText.isNullOrEmpty()) {
                    // Có thể gửi event trực tiếp nếu cần, nhưng ở đây ta dùng cơ chế "pull" từ Flutter
                }
            }
        }
    }
}