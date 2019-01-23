package com.example.salon;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import swarajsaaj.smscodereader.interfaces.OTPListener;
import swarajsaaj.smscodereader.receivers.OtpReader;

public class MainActivity extends FlutterActivity implements OTPListener {
  private static final String CHANNEL = "workflowapp.flutter.io/devicedetail";
  private static final String CHANNEL_VERSION = "com.example.workflowsapp/version";
  private static final String TAG = MainActivity.class.getName();
  private static final int MY_PERMISSIONS_REQUEST_RECEIVE_SMS = 4242;
  private Result sms_result;
  private Result otp_result;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("getSerialId"))
                  result.success(getSerialId());
                else if (call.method.equals("smsPermission")) {
                  MainActivity.this.sms_result = result;
                  checkSMSPermission();
                } else if (call.method.equals("getOtp")) {
                  MainActivity.this.otp_result = result;
                  initOtpReader();
                } else if (call.method.equals("getVersion")) {
                  result.success(BuildConfig.VERSION_CODE);
                } else result.notImplemented();
              }
            });
  }

  private void initOtpReader() {
    OtpReader.bind(this, "TFCTOR");

  }

  @Override
  protected void onDestroy() {
    OtpReader.bind(null, null);

    super.onDestroy();
  }

  @Override
  public void otpReceived(String smsText) {
    //Do whatever you want to do with the text

    String otp = smsText.replaceAll("[^0-9]", "");
    otp_result.success(otp);
  }

  private void checkSMSPermission() {
    if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.M) {
      // only for gingerbread and newer versions
      sms_result.success(true);
    } else if (ContextCompat.checkSelfPermission(MainActivity.this,
            Manifest.permission.RECEIVE_SMS)
            != PackageManager.PERMISSION_GRANTED) {

      // Permission is not granted
      // Should we show an explanation?
      if (ActivityCompat.shouldShowRequestPermissionRationale(MainActivity.this,
              Manifest.permission.RECEIVE_SMS)) {
        // Show an explanation to the user *asynchronously* -- don't block
        // this thread waiting for the user's response! After the user
        // sees the explanation, try again to request the permission.
        ActivityCompat.requestPermissions(MainActivity.this,
                new String[]{Manifest.permission.RECEIVE_SMS},
                MY_PERMISSIONS_REQUEST_RECEIVE_SMS);
      } else {
        // No explanation needed; request the permission
        ActivityCompat.requestPermissions(MainActivity.this,
                new String[]{Manifest.permission.RECEIVE_SMS},
                MY_PERMISSIONS_REQUEST_RECEIVE_SMS);

        // MY_PERMISSIONS_REQUEST_READ_CONTACTS is an
        // app-defined int constant. The callback method gets the
        // result of the request.
      }
    } else {
      // Permission has already been granted
      sms_result.success(true);
    }
  }


  // private String getIMEIId(){
  //  TelephonyManager tm = (TelephonyManager) getSystemService(android.content.Context.TELEPHONY_SERVICE);
  //  return tm.getDeviceId();
  // return "IMEI";
  // }

  private String getSerialId() {
    if (Build.VERSION.SDK_INT < 26)
      return Build.SERIAL;
    else
      return Build.getSerial();

  }

  @Override
  public void onRequestPermissionsResult(int requestCode,
                                         String permissions[], int[] grantResults) {

    switch (requestCode) {
      case MY_PERMISSIONS_REQUEST_RECEIVE_SMS: {
        // If request is cancelled, the result arrays are empty.
        if (grantResults.length > 0
                && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
          // permission was granted, yay! Do the
          // contacts-related task you need to do.
          sms_result.success(true);
          return;
        } else {
          // permission denied, boo! Disable the
          // functionality that depends on this permission.
          sms_result.success(false);
          return;
        }

      }

      // other 'case' lines to check for other
      // permissions this app might request.
    }
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }
}
