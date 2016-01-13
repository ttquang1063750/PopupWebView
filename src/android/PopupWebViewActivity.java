package com.github.poupWebView;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.ImageView;

import com.gumiviet.mobione.R;

public class PopupWebViewActivity extends Activity {
    private PopupWebViewActivity _current;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        _current = this;
        setContentView(R.layout.activity_popup_view);
        Intent intent = getIntent();
        String url = intent.getStringExtra("url");
        WebView webview = (WebView) findViewById(R.id.webView);
        WebSettings settings = webview.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setAppCacheEnabled(true);
        settings.setJavaScriptCanOpenWindowsAutomatically(false);
        settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);

        webview.loadUrl(url);
        ImageView btnClose = (ImageView) findViewById(R.id.btnClose);
        btnClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                _current.finish();
            }
        });
    }
}
