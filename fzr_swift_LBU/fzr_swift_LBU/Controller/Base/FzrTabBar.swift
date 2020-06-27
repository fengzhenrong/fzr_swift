//
//  FzrTabBar.swift
//  fzr_swift_LBU
//
//  Created by feng zhenrong on 2020/6/7.
//  Copyright © 2020 feng zhenrong. All rights reserved.
//

import UIKit

class FzrTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl {
            var frame = button.frame
            frame.origin.y = -2
            button.frame = frame
        }
    }

}
