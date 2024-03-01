package com.imagerotate

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.util.Base64
import com.facebook.react.bridge.*
import java.io.File
import java.lang.Exception
import java.net.URI
import java.util.UUID

class ImageRotateModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  private var base64Rotate = Base64Rotate(reactApplicationContext);
  private var fileRotate = FileRotate(reactApplicationContext);

  @ReactMethod
  fun rotate(options: ReadableMap, promise: Promise) {
    val type: String = options.getString("type")!!
    val content: String = options.getString("content")!!
    val degAngle: Int = options.getInt("angle")

    if (type == "base64"){
      val pathFile = base64Rotate.rotate(content, degAngle)
      return promise.resolve(pathFile)
    }

    try {
      val pathFile = fileRotate.rotate(content, degAngle)
      return promise.resolve(pathFile)
    }catch (e: Exception){
      promise.reject(e.cause)
    }
  }

  companion object {
    const val NAME = "ImageRotate"
  }
}
