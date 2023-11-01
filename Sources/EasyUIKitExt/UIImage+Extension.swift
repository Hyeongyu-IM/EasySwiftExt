//
//  ImageExtension.swift
//  bbarge
//
//  Created by 임현규 on 2021/06/12.
//

import UIKit
import CoreGraphics

public extension UIImage {
    /**
     Tag: #imageResize, #Reisze
     */
    func resizeImage(_ dimension: CGFloat, opaque: Bool,
                     contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        
        let size = self.size
        let aspectRatio =  size.width/size.height
        
        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = opaque
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }
}

public extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInKB: Int) -> Data? {
        let sizeInBytes = expectedSizeInKB * 1024
        var needCompress: Bool = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        var count = 9
        while (needCompress && compressingValue > 0.0) {
            if let data: Data = self.jpegData(compressionQuality: compressingValue) {
                if count == 0 {
                    return data
                }
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                    count -= 1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return data
            }
        }
        return self.jpegData(compressionQuality: 1)
    }
}

public extension UIImage {
    /**
     이미지의 알파(alpha) 값을 조정하여 투명도를 변경합니다.

     - Parameters:
       - alpha: 이미지에 적용할 알파 값. 0.0에서 1.0 사이의 값을 가져야 합니다.
     
     - Returns: 알파 값을 조정한 이미지.
     
     - Tag: #이미지알파 #imageAlpha #Alpha, #image
    */
    func withAlpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard UIGraphicsGetCurrentContext() != nil else {
            return nil
        }
        
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: area, blendMode: .normal, alpha: alpha)
        let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return modifiedImage
    }
}
