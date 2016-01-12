# PopupWebView
This plugin support for platform iOS > 6.0 and android > 4.0
# Usage

```js
document.addEventListener("deviceready", function () {
  var url = "http://google.com"
  var onSuccess = function(result){};
  var onError = function(err){};
  window.plugin
        .PopupWebView
        .show(url, onSuccess, onError);
}, false);
```
