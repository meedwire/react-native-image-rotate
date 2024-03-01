package com.imagerotate

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import com.facebook.react.bridge.ReactApplicationContext
import java.io.File
import java.io.FileOutputStream
import java.lang.Error
import java.net.URI

class FileRotate(appContext: ReactApplicationContext){
  private var helpers = Helpers(appContext);

  fun rotate(contentURI: String, degAngle: Int): String{
    val uri = URI.create(contentURI);

    val originalFileBitmap = BitmapFactory.decodeFile(uri.path) ?: throw Error("LoadOriginalFile")

    val fileUri = helpers.getFileURI("jpeg")

    val file = File(fileUri.path)

    if (degAngle % 360 != 0){
      val matrix = Matrix().apply { postRotate(degAngle.toFloat()) }
      val rotatedBitmap = Bitmap.createBitmap(
        originalFileBitmap,
        0, 0,
        originalFileBitmap.width, originalFileBitmap.height,
        matrix,
        true
      )

      originalFileBitmap.recycle()

      FileOutputStream(file).use { out ->
        rotatedBitmap.compress(Bitmap.CompressFormat.JPEG, 100, out)
      }
      rotatedBitmap.recycle()
    }else{
      FileOutputStream(file).use { out ->
        originalFileBitmap.compress(Bitmap.CompressFormat.JPEG, 100, out)
      }
      originalFileBitmap.recycle()
    }

    return file.toURI().toString()
  }
}
