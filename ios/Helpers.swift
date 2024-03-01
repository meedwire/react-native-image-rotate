//
//  Helpers.swift
//  react-native-video-manager
//
//  Created by Meedwire on 18/10/22.
//

import Foundation
import AVFoundation

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

func getFileURL(fileExtension: String) -> URL {
    let fileName = UUID().uuidString
    
    createDirectory()
    
    let documentUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:false)
    let path = documentUrl!.absoluteString + "react-native-image-rotate"
    
    let url = URL(string: path)!.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    return url
}

func createDirectory(){
    let url = FileManager.default.urls(
        for: .documentDirectory, in: .userDomainMask
    )
        .first
    
    let dataPath = url?.appendingPathComponent("react-native-image-rotate")
    
    if dataPath?.path != nil {
        if !FileManager.default.fileExists(atPath: dataPath!.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath!.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

enum ImageProcessingError: Error {
    case base64DecodingError
    case imageCreationError
    case jpegConversionError
    case uriError
    case fileAccessError
    
    case unexpectedError
    
    var code: String {
        switch self {
        case .base64DecodingError:
            return "Base64DecodingError"
        case .imageCreationError:
            return "ImageCreationError"
        case .jpegConversionError:
            return "JpegConversionError"
        case .uriError:
            return "UriError"
        case .fileAccessError:
            return "FileAccessError"
        case .unexpectedError:
            return "UnexpectedError"
        }
    }
}



