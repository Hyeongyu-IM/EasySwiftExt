//
//  TimeInerval+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2023/05/29.
//  Copyright © 2023 com.leisure. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    static public var oneHour: TimeInterval {
        return 3600
    }
    
    static public var twoHour: TimeInterval {
        return oneHour * 2
    }
    
    static public var oneDay: TimeInterval {
        return oneHour * 24
    }
    
    static public var twoDays: TimeInterval {
        return oneDay * 2
    }
    
    static public var threeDays: TimeInterval {
        return oneDay * 3
    }
    
    static public var oneWeek: TimeInterval {
        return oneDay * 7
    }
    
    static public var oneMonth: TimeInterval {
        return oneDay * 30
    }
    
    static public var oneYear: TimeInterval {
        return oneDay * 365
    }
    
    static public func customHour(hour: Int) -> TimeInterval {
        return oneHour * Double(hour)
    }
}
