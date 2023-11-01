//
//  UIViewController+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

public extension UIViewController {
    /**
     주어진 뷰 컨트롤러를 최상위 뷰 컨트롤러 위에 모달로 표시합니다.
     
     - Parameters:
        - viewController: 모달로 표시할 뷰 컨트롤러.
        - animated: 애니메이션 사용 여부.
     Tag: #Winodow, #Modal
     */
    func presentOnTop(_ viewController: UIViewController, animated: Bool) {
        var topViewController = self
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        topViewController.present(viewController, animated: animated)
    }
}
