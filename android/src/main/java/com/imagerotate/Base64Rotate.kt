package com.imagerotate

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.util.Base64
import com.facebook.react.bridge.ReactApplicationContext
import java.io.File

class Base64Rotate(appContext: ReactApplicationContext) {
  private var helpers = Helpers(appContext);

  fun rotate(content: String, degAngle: Int): String {
    val decodedBase64 = Base64.decode(content, Base64.DEFAULT)

    val fileUri = helpers.getFileURI("jpeg")
    val file = File(fileUri.path)

    val matrix = Matrix()

    matrix.postRotate(degAngle.toFloat())

    val bitmapFactory = BitmapFactory.decodeByteArray(decodedBase64, 0, decodedBase64.size)
    val bitmap = Bitmap.createBitmap(bitmapFactory, 0, 0, bitmapFactory.width, bitmapFactory.height, matrix, true);

    file.outputStream().use {
      bitmap.compress(Bitmap.CompressFormat.JPEG, 100, it)
    }

    bitmap.recycle()

    return file.toURI().toString()
  }
}
