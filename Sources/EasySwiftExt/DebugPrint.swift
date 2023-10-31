//
//  EtcExtension.swift
//  bbarge
//
//  Created by 임현규 on 2021/06/11.
//

import UIKit
import Alamofire

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
    #if !RELEASE
    let date = Date()
    let dateFormmat = DateFormatter()
    dateFormmat.calendar = .current
    dateFormmat.dateFormat = "디버깅 로그 YYYY-MM-dd hh:mm:ss"
    let formatDate = dateFormmat.string(from: date)
    if let obj = object {
        print("\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : \(obj)")
    } else {
        print("\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : nil")
    }
    #endif
}

public func ReceiveLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
    #if !RELEASE
    let date = Date()
    let dateFormmat = DateFormatter()
    dateFormmat.calendar = .current
    dateFormmat.dateFormat = "[서버데이터] YYYY-MM-dd hh:mm:ss"
    let formatDate = dateFormmat.string(from: date)
    if let obj = object {
        print("\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) \n| URL |---> \(obj)")
    } else {
        print("\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) : nil")
    }
    #endif
}

public func RouteLog<T>(_ route: T, filename: String = #file, line: Int = #line, funcName: String = #function) {
    #if !RELEASE
    guard let route = route as? LebbarAPI else { return }
    let date = Date()
    let dateFormmat = DateFormatter()
    dateFormmat.calendar = .current
    dateFormmat.dateFormat = "[데이터 요청] YYYY-MM-dd hh:mm:ss"
    let formatDate = dateFormmat.string(from: date)
    let baseURL = Bundle.main.infoDictionary!["APP_SERVER_URL"] as! String
    let properties = route.requeseProperties
    let requestURL = "| BaseURL | : \(baseURL)\n| Parameters | : \(properties.path)"
    if properties.method == .GET {
        if let _ = properties.query {
            print("\n\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) \n| GET URL |---> RequestingURL(\(HTTPMethod(rawValue: properties.method.rawValue)) = \(requestURL)\(properties.query!.reduce("?\n") { $0 + "\($1.key)" + "=" + ("\($1.value)") + "\n" })")
            return
        }
        print("\n\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) \n| GET URL |---> RequestingURL(\(HTTPMethod(rawValue: properties.method.rawValue)) = \(requestURL)")
    } else if properties.method == .POST {
        print("\n\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) \n| POST UR] |---> RequestingURL(\(HTTPMethod(rawValue: properties.method.rawValue)) = \(requestURL)\(properties.query ?? [:])" )
    } else if properties.method == .MultiPart {
        print("\n\(formatDate) \(filename.components(separatedBy: "/").last ?? "")(\(line)) : \(funcName) \n| MultiPart URL |---> RequestingURL(\(HTTPMethod(rawValue: properties.method.rawValue)) = \(requestURL)\(properties.query!.reduce("?\n") { $0 + "\($1.key)" + "=" + ("\($1.value)") + "\n" })")
    }
    #endif
}

