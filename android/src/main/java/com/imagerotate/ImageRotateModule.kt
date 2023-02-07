package com.imagerotate

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.util.Base64
import com.facebook.react.bridge.*
import java.io.File
import java.net.URI
import java.util.UUID

class ImageRotateModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun rotate(options: ReadableMap, promise: Promise) {
    val type: String = options.getString("type")!!
    val content: String = options.getString("content")!!
    val degAngle: Int = options.getInt("angle")!!

    val imageBytes = Base64.decode(content, Base64.DEFAULT)

    val cacheDir = reactApplicationContext.cacheDir.toString()

    val path = URI.create(cacheDir + "/" + UUID.randomUUID() + ".jpeg")

    val file = File(path.path)

    val matrix = Matrix()

    matrix.postRotate(degAngle.toFloat())

    val bitmapFactory = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
    val bitmap = Bitmap.createBitmap(bitmapFactory, 0, 0, bitmapFactory.width, bitmapFactory.height, matrix, true);

    file.outputStream().use {
      bitmap.compress(Bitmap.CompressFormat.JPEG, 100, it)
    }

    promise.resolve("file:///"+file.absoluteFile)
  }

  companion object {
    const val NAME = "ImageRotate"
  }
}
