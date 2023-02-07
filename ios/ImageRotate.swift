@objc(ImageRotate)
class ImageRotate: NSObject {

  @objc(rotate:withResolver:withRejecter:)
    func rotate(options: NSDictionary, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        let type = options.value(forKey: "type")
    
        let content = options.value(forKey: "content") as! String
      
        let degAngle = options.value(forKey: "angle")! as! Int
      
        let angle = CGFloat(degAngle) * (CGFloat.pi / 180)
        let data: Data = Data(base64Encoded: content, options: .ignoreUnknownCharacters)!
        let image = UIImage(data: data)
        let dataImage = image?.rotate(radians: angle).jpegData(compressionQuality: 1.0)
        
        let path = getFileURL(fileExtension: "jpeg")

        try? dataImage?.write(to: path!)
      
        return resolve(path?.absoluteString)
  }
}
