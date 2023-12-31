//
//  UINavgationController+Extension.swift
//  bbarge
//
//  Created by Tony on 2022/07/22.
//

import UIKit

public extension UINavigationController {
    
    /**
     `pushViewController` 메서드를 호출할 때 완료 핸들러를 추가하는 메서드입니다.
     
     `pushViewController(_:animated:)` 메서드를 호출한 후, `animated`가 `true`이고 `transitionCoordinator`가 있는 경우 애니메이션 완료 후에 완료 핸들러를 실행합니다. 그렇지 않은 경우 즉시 완료 핸들러를 실행합니다.
     
     - Parameters:
     - viewController: 스택에 추가할 뷰 컨트롤러입니다.
     - animated: 애니메이션 사용 여부를 나타냅니다.
     - completion: 완료 핸들러로 실행될 클로저입니다.
     */
    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    /**
     `popViewController` 메서드를 호출할 때 완료 핸들러를 추가하는 메서드입니다.
     
     `popViewController(animated:)` 메서드를 호출한 후, `animated`가 `true`이고 `transitionCoordinator`가 있는 경우 애니메이션 완료 후에 완료 핸들러를 실행합니다. 그렇지 않은 경우 즉시 완료 핸들러를 실행합니다.
     
     - Parameters:
     - animated: 애니메이션 사용 여부를 나타냅니다.
     - completion: 완료 핸들러로 실행될 클로저입니다.
     */
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    /**
     `popToViewController` 메서드를 호출할 때 완료 핸들러를 추가하는 메서드입니다.
     
     `popToViewController(_:animated:)` 메서드를 호출한 후, `animated`가 `true`이고 `transitionCoordinator`가 있는 경우 애니메이션 완료 후에 완료 핸들러를 실행합니다. 그렇지 않은 경우 즉시 완료 핸들러를 실행합니다.
     
     - Parameters:
     - viewController: 스택에서 이동할 목표 뷰 컨트롤러입니다.
     - animated: 애니메이션 사용 여부를 나타냅니다.
     - completion: 완료 핸들러로 실행될 클로저입니다.
     */
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        popToViewController(viewController, animated: true)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    /// BAck to spicefic vc in the stack
    ///
    /// - Parameters:
    ///   - type: UIViewController
    ///   - animated: animated
    ///   - instead: 기존 뷰컨이 없으면 새로 만들어진걸 껴넣습니다
    @discardableResult
    func backTo<T: UIViewController>(_ type: T.Type, animated: Bool = true,_ instead: UIViewController) -> UIViewController {
        if let vc = viewControllers.first(where: { $0 is T }) {
            popToViewController(vc, animated: animated)
            return vc
        }
        var currentStack = self.viewControllers
        let currentTop = currentStack.removeLast()
        currentStack.append(instead)
        currentStack.append(currentTop)
        self.viewControllers = currentStack
        self.backTo(type, instead)
        return instead
    }
}
