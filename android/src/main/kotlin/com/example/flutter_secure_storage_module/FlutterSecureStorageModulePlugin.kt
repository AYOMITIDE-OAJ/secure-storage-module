package com.example.flutter_secure_storage_module

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterSecureStorageModulePlugin: FlutterPlugin, MethodCallHandler {
 
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_secure_storage_module")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
   when (call.method){
    "write" -> handleWrite(call, result)
    "read" -> handleRead(call, result)
    "delete" -> handleDelete(call, result)
    "containsKey" -> handleContainsKey(call, result)
    else -> result.notImplemented()
   }
  }

   private fun handleWrite(call: MethodCall, result: Result) {
    val key = call.argument<String>("key")
    val encryptedValue = call.argument<String>("value")

    if (key == null || encryptedValue == null) {
        result.error("INVALID_ARGUMENTS", "Key or value is missing", null)
        return
    }

    // Store the encryptedValue in SharedPreferences directly
    val sharedPreferences = context.getSharedPreferences("FlutterSecureStorage", Context.MODE_PRIVATE)
    sharedPreferences.edit().putString(key, encryptedValue).apply()

    result.success(null)
   }

   private fun handleRead(call: MethodCall, result: Result){
    val key = call.argument<String>("key")

    if (key == null){
      result.error("INVALID_ARGUMENTS", "Key is missing", null)
      return
    }

    // Read the encrypted value from SharedPreferences
    val sharedPreferences = context.getSharedPreferences("FlutterSecureStorage", Context.MODE_PRIVATE)
    val encryptedValue = sharedPreferences.getString(key, null)

    result.success(encryptedValue)
   }

   private fun handleDelete(call: MethodCall, result: Result) {
    val key = call.argument<String>("Key")

    if (key == null){
      result.error(
        "KEY_MISSING",
        "Required parament 'key' was null",
        null
      )
      return
    }

    // Delete key from SharedPreferences
    sharedPreferences.edit().remove(key).apply()
    if (!sharedPreferences.edit().remove(key).commit()){
      result.error(
        "DELETE_FAILED",
        "Failed to delete key '$key' from storage",
        null
      )
      return
    }

    result.success(null)
   }

   private fun handleContainsKey(call: MethodCall, result: Result){
    val key = call.argument<String>("key")

    if (key == null){
      result.error(
        "KEY_MISSING",
        "Required parameter 'key' was null",
        null
      )
      return
    }

    // Check if key existes in SharedPreferences
    val contains = sharedPreferences.contains(key)

    result.success(contains);
   }
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
