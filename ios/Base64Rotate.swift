//
//  Base64Rotate.swift
//  react-native-image-rotate
//
//  Created by Meedwire on 01/03/24.
//

import Foundation

func base64Rotate(content: String, degAngle: Int) throws -> String? {
    let angle = CGFloat(degAngle) * (CGFloat.pi / 180)
    
    guard let data = Data(base64Encoded: content, options: .ignoreUnknownCharacters) else {
        throw ImageProcessingError.base64DecodingError
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
