@objc(ImageRotate)
class ImageRotate: NSObject {
    
    @objc(rotate:withResolver:withRejecter:)
    func rotate(options: NSDictionary, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        let type = options.value(forKey: "type") as! String
        
        let content = options.value(forKey: "content") as! String
        
        let degAngle = options.value(forKey: "angle")! as! Int
        
        if (type == "base64"){
            do {
                guard let stringPath = try base64Rotate(content: content, degAngle: degAngle) else {
                    return reject(ImageProcessingError.unexpectedError.code, "Unexpected error", ImageProcessingError.unexpectedError)
                }
                
                return resolve(stringPath)
            } catch let error as ImageProcessingError {
                return reject(error.code, "Error processing image", error)
            } catch {
                return reject(ImageProcessingError.unexpectedError.code, "Unexpected error", ImageProcessingError.unexpectedError)
            }
        }
        
        do {
            guard let stringPath = try fileRotate(contentURI: content, degAngle: degAngle) else {
                return reject(ImageProcessingError.unexpectedError.code, "Unexpected error", ImageProcessingError.unexpectedError)
            }
            
            return resolve(stringPath)
        } catch let error as ImageProcessingError {
            return reject(error.code, "Error processing image", error)
        } catch {
            return reject(ImageProcessingError.unexpectedError.code, "Unexpected error", ImageProcessingError.unexpectedError)
        }
        
    }
}
