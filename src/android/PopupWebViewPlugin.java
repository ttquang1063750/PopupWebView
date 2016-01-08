package com.github.ttquang.poupWebView;

import android.content.Intent;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * This class echoes a string called from JavaScript.
 */
public class PopupWebViewPlugin extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("show")) {
            JSONObject message = args.getJSONObject(0);
            String url = message.getString("url");
            this.show(url, callbackContext);
            return true;
        }
        return false;
    }

    private void show(String url, CallbackContext callbackContext) {
        if (url != null && url.length() > 0) {
            Intent intent = new Intent(cordova.getActivity().getBaseContext(), PopupWebViewActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intent.putExtra("url", url);
            callbackContext.success(url);
            cordova.getActivity().startActivity(intent);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
