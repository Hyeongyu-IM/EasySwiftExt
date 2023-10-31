//
//  UIWindow+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

extension UIWindow {
    /**
     현재 화면에서 가장 보이는(view hierarchy에서 최상위) 뷰 컨트롤러를 반환합니다.
     Tag: #visible, #Top
     */
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    private func visibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
    
    /**
     현재 윈도우의 루트 뷰 컨트롤러를 다른 뷰 컨트롤러로 대체합니다.
     
     - Parameters:
        - replacementController: 대체할 뷰 컨트롤러.
        - animated: 애니메이션 사용 여부.
        - completion: 대체 작업 완료 후 실행될 클로저.
     Tag: #Window, #change
     */
    func replaceRootViewController(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot())
        self.addSubview(snapshotImageView)
        let dismissCompletion = { () -> Void in // dismiss all modal view controllers
            self.rootViewController = replacementController
            self.bringSubviewToFront(snapshotImageView)
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                }, completion: { (success) -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            } else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        if self.rootViewController!.presentedViewController != nil {
            self.rootViewController!.dismiss(animated: false, completion: dismissCompletion)
        } else {
            dismissCompletion()
        }
    }

    /**
     현재 윈도우의 스냅샷을 생성하여 이미지로 반환합니다.
     
     - Returns: 윈도우의 스냅샷 이미지.
     Tag: #스냅샷, #SnapShot
     */
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return result
    }
}
