//
//  UIStackView+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

extension UIStackView {
    /**
     뷰를 배열 형태의 하위 뷰에서 제거하고 해당 뷰를 상위 뷰에서도 제거합니다.
     
     - Parameters:
        - view: 제거할 뷰입니다.
     Tag: #StackView, #Remove
     */
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    /**
     배열 형태의 하위 뷰들을 모두 스택 뷰에서 제거하고 해당 뷰들을 상위 뷰에서도 제거합니다.
     Tag: #StackView, #Remove
     */
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeFully(view: view)
        }
    }
}
