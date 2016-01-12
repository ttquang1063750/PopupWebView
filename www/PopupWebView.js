var exec = require('cordova/exec');
var PopupWebView = function() {};

PopupWebView.prototype.show = function(url, successCallback, errorCallback){
    exec(successCallback, errorCallback, "PopupWebView", "show", [{url:url}]);
};

if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.PopupWebView) {
    window.plugins.PopupWebView = new PopupWebView();
}

if (typeof module != 'undefined' && module.exports) {
    module.exports = PopupWebView;
}