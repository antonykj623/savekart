package com.integra.savekart

import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.integra.savekart.databinding.ActivityNativeBinding

class WebNativeActivity : AppCompatActivity() {

    private lateinit var binding: ActivityNativeBinding
    private lateinit var upiPaymentLauncher: ActivityResultLauncher<Intent>

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Use ViewBinding or setContentView(R.layout.activity_native)
        binding = ActivityNativeBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val urlToLoad = intent.getStringExtra("url") ?: ""

        // Register launcher
        upiPaymentLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == Activity.RESULT_OK && result.data != null) {
                val response = result.data?.getStringExtra("response")
                Log.d("UPI Response", response ?: "No response")
                // Handle UPI payment success
            } else {
                Log.d("UPI Payment", "Transaction cancelled by user")
            }
        }

        setupWebView(urlToLoad)
    }

    private fun setupWebView(url: String) {
        val webView = binding.webview
        webView.settings.javaScriptEnabled = true
        webView.settings.loadsImagesAutomatically = true
        webView.settings.setSupportMultipleWindows(true)
        webView.settings.javaScriptCanOpenWindowsAutomatically = true
        webView.scrollBarStyle = View.SCROLLBARS_INSIDE_OVERLAY
        webView.webViewClient = object : WebViewClient() {

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                Log.d("WebView", "Started loading: $url")
            }

            @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
            override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
                val urlString = request.url.toString()
                return handleUrl(view, urlString)
            }

            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                return handleUrl(view, url)
            }

            private fun handleUrl(view: WebView, url: String): Boolean {
                Log.d("Current_browser_url",url)
                if (url.contains("upi://pay")) {
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                    try {
                        upiPaymentLauncher.launch(intent)
                    } catch (e: Exception) {
                        Log.e("UPI Error", "No UPI app found.")
                        view.loadUrl("javascript:(function() { document.getElementsByClassName(\"intent-off\")[0].click();})()")
                    }
                    return true
                }
                else if(url.contains("https://mysaveapp.com/ecommercepayment/paymentgateway/result.php"))
                {
                    val returnIntent = Intent()
                    returnIntent.putExtra("result_url", url) // You can pass any key/value
                    setResult(Activity.RESULT_OK, returnIntent)
                    finish()

                }
                view.loadUrl(url)
                return true
            }
        }

        webView.loadUrl(url)
    }
}
