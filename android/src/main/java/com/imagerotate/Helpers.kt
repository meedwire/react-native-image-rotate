package com.imagerotate

import com.facebook.react.bridge.ReactApplicationContext
import java.io.File
import java.net.URI
import java.util.UUID

class Helpers(private var appContext: ReactApplicationContext) {
  private fun createDirectory(): String{
    val cachePath = appContext.cacheDir.toString()
    val cacheImagePath = "$cachePath/react-native-image-rotate"

    val file = File(cacheImagePath);

    if (!file.exists()){
      file.mkdirs()
    }

    return cacheImagePath;
  }

  fun getFileURI(fileExtension: String): URI {
    val fileName = UUID.randomUUID().toString();
    val fileCacheDir = createDirectory()
    return URI.create("$fileCacheDir/$fileName.$fileExtension")
  };
}



