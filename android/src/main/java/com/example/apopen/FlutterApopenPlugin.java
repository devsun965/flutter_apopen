package com.example.apopen;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.alipay.share.sdk.openapi.APImageObject;
import com.alipay.share.sdk.openapi.APWebPageObject;
import com.alipay.share.sdk.openapi.IAPApi;
import com.alipay.share.sdk.openapi.APTextObject;
import com.alipay.share.sdk.openapi.APMediaMessage;
import com.alipay.share.sdk.openapi.SendMessageToZFB;
import com.alipay.share.sdk.openapi.APAPIFactory;

import java.util.HashMap;
import java.util.Map;


/**
 * FlutterNativeLogPlugin
 */
public class FlutterApopenPlugin implements MethodCallHandler {

    private static Registrar myRegistrar;

    private IAPApi _api;
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        myRegistrar = registrar;
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.sunpub/apopen");
        channel.setMethodCallHandler(new FlutterApopenPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("registerAp")) {
            registerAP(call,result);
        }else if (call.method.equals("shareText")) {
            sendTextMessage(call, result);
        }else if (call.method.equals("shareImageData")) {
            sendImageData(call, result);
        }else if (call.method.equals("shareImageUrl")) {
            sendImageUrl(call, result);
        }else if (call.method.equals("shareWebUrl") || call.method.equals("shareWebData")) {
            sendWebPageWithImg(call, result);
        } else {
            result.notImplemented();
        }
    }

    private void registerAP(MethodCall call, Result result) {
        String appId = call.argument("appId");
        _api = APAPIFactory.createZFBApi(myRegistrar.context(),appId,false);
        boolean isInstalled = _api.isZFBSupportAPI();
        System.out.print(isInstalled);
    }

    //文本信息分享
    private void sendTextMessage(MethodCall call, Result result) {
        //初始化一个APTextObject对象
        APTextObject textObject = new APTextObject();
        textObject.text = call.argument("text");

        //用APTextObject对象初始化一个APMediaMessage对象
        APMediaMessage mediaMessage = new APMediaMessage();
        mediaMessage.mediaObject = textObject;

        //构造一个Req
        SendMessageToZFB.Req req = new SendMessageToZFB.Req();
        req.message = mediaMessage;

        //调用api接口发送消息到支付宝
        boolean boolResult = _api.sendReq(req);
        Map resultMap = new HashMap();
        resultMap.put("platform","Android");
        resultMap.put("result",boolResult);
        result.success(resultMap);
    }
    // 传图片数据
    private void sendImageData(MethodCall call, Result result) {
        byte[] imageByte = call.argument("imageData");
        Bitmap bmp = BitmapFactory.decodeByteArray(imageByte,0,imageByte.length);
        APImageObject imageObject = new APImageObject(bmp);
        APMediaMessage mediaMessage = new APMediaMessage();
        mediaMessage.mediaObject = imageObject;
        SendMessageToZFB.Req req = new SendMessageToZFB.Req();
        req.message = mediaMessage;
        req.transaction = buildTransaction("image");
        bmp.recycle();
        //调用api接口发送消息到支付宝
        boolean boolResult = _api.sendReq(req);
        Map resultMap = new HashMap();
        resultMap.put("platform","Android");
        resultMap.put("result",boolResult);
        result.success(resultMap);
    }
    // 传图片地址
    private void sendImageUrl(MethodCall call, Result result) {

        APImageObject imageObject = new APImageObject();
        imageObject.imageUrl = call.argument("imageUrl");
        APMediaMessage mediaMessage = new APMediaMessage();
        mediaMessage.mediaObject = imageObject;
        SendMessageToZFB.Req req = new SendMessageToZFB.Req();
        req.message = mediaMessage;
        req.transaction = buildTransaction("image");
        //调用api接口发送消息到支付宝
        boolean boolResult = _api.sendReq(req);
        Map resultMap = new HashMap();
        resultMap.put("platform","Android");
        resultMap.put("result",boolResult);
        result.success(resultMap);
    }
    // 传网页，图片缩略图为url
    private void sendWebPageWithImg(MethodCall call, Result result) {

        APWebPageObject webPageObject = new APWebPageObject();
        webPageObject.webpageUrl = call.argument("wepageUrl");
        APMediaMessage webMessage = new APMediaMessage();
        webMessage.title = call.argument("title");
        webMessage.description = call.argument("desc");
        webMessage.mediaObject = webPageObject;
        if(call.method.equals("shareWebData")) {
            webMessage.thumbData = call.argument("imageData");
        }else  {
            webMessage.thumbUrl = call.argument("imageUrl");
        }

        SendMessageToZFB.Req webReq = new SendMessageToZFB.Req();
        webReq.message = webMessage;
        webReq.transaction = buildTransaction("webpage");
        //调用api接口发送消息到支付宝
        boolean boolResult = _api.sendReq(webReq);
        Map resultMap = new HashMap();
        resultMap.put("platform","Android");
        resultMap.put("result",boolResult);
        result.success(resultMap);
    }

    private String buildTransaction(final String type) {
        return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
    }

}