//
//  NSAttributeString+Extension.swift
//  trot
//
//  Created by 임현규 on 2022/07/20.
//

import UIKit


extension NSAttributedString {
    /**
     updateAttString
     
     NSAttributedString의 String값을 업데이트합니다.
     label의attributedText에 두가지 옵션 들어갈때 쓰기 편함
     [사용법 예시]
     ```swift
     userNameLabel.attributedText = clueName.updateAttString("Ruyha") + "님 안녕하세요.".heading3(color: .gray100)
     ```
     Author: [작성자]
     Tag:
     */
    public func updateAttString(_ text: String) -> NSAttributedString {
        let attributes = self.attributes(at: 0, effectiveRange: nil)
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
    
    public func addIcon(icon: UIImage, isLeftIcon: Bool = true) -> NSAttributedString {
        if let font = self.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont {
            let mutableAttText = NSMutableAttributedString()
            mutableAttText.append(self)
            let attachment = NSTextAttachment()
            attachment.image = icon
            attachment.bounds = .init(x: 0,
                                      y: ((font.capHeight - icon.size.height).rounded() / 2),
                                      width: icon.size.width, height: icon.size.height)
            let attachmentString = NSAttributedString(attachment: attachment)
            if isLeftIcon == true {
                mutableAttText.insert(attachmentString, at: 0)
            } else {
                mutableAttText.append(attachmentString)
            }
            return mutableAttText
        } else {
            print("UIFont not found")
        }
        return self
    }
    
    /**
     텍스트가 넓이 리턴
     */
    public var labelWidth: CGFloat {
        if let font = self.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont {
            let text = self.string as NSString
            return text.size(withAttributes: [.font: font]).width
        }
        return 0
    }
}

// MARK: - Operators
public extension NSAttributedString {
    static public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
    
    public func applying(attributes: [Key: Any]) -> NSAttributedString {
        guard !string.isEmpty else { return self }
        
        let copy = NSMutableAttributedString(attributedString: self)
        copy.addAttributes(attributes, range: NSRange(0..<length))
        return copy
    }
}
