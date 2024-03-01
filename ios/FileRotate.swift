//
//  FileRotate.swift
//  react-native-image-rotate
//
//  Created by Meedwire on 01/03/24.
//

import Foundation

func fileRotate(contentURI: String, degAngle: Int) throws -> String? {
    let angle = CGFloat(degAngle) * (CGFloat.pi / 180)
    
    guard let fileURL = URL(string: contentURI) else {
        throw ImageProcessingError.uriError
    }
    
    guard let data = try? Data(contentsOf: fileURL) else {
        throw ImageProcessingError.fileAccessError
    }
    
    guard let image = UIImage(data: data) else {
        throw ImageProcessingError.imageCreationError
    }
    
    let rotatedImage = image.rotate(radians: angle)
    
    guard let dataImage = rotatedImage.jpegData(compressionQuality: 1.0) else {
        throw ImageProcessingError.jpegConversionError
    }
    
    let path = getFileURL(fileExtension: "jpeg")
    
    try dataImage.write(to: path)
    
    return path.absoluteString
}
