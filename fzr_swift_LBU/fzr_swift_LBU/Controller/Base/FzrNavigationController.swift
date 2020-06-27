//
//  FzrNavigationController.swift
//  fzr_swift_LBU
//
//  Created by feng zhenrong on 2020/6/7.
//  Copyright © 2020 feng zhenrong. All rights reserved.
//

import UIKit


@objc protocol FzrNavigationDelegate {
     @objc optional func navback() -> ()
}

class FzrNavigationController: UINavigationController {

    lazy var backButton : UIButton = {
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        let image = UIImage(named: "return")
        backBtn.setImage(image, for: .normal)
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: 0)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        backBtn.backgroundColor = UIColor.red
        return backBtn
    }()
    
    var fzrdelegate: FzrNavigationDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fzr_barBackgroundColor = UIColor.green
        self.fzr_barTintColor = UIColor.gray
        // Do any additional setup after loading the view.
    }
    
    // push 隐藏标签栏
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
//             替换系统返回键
//            viewController.addNavigationBarLeftView(self.backButton)
            let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            leftSpace.width = 0
            let leftButonItem = UIBarButtonItem(image: UIImage(named: "return"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItem = leftButonItem
            viewController.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0,left: -15,bottom: 0,right: 0)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
    /// 设置导航栏默认的背景颜色
    func setupNavBarAppearence() {
        
    }
    
    @objc func back() -> () {
        guard let _ = fzrdelegate?.navback?() else{
            print("-------返回上一页-----------")
            self.popViewController(animated: true)
            return
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    func addNavigationBarLeftView(_ leftView: UIView) {
        let leftItem = UIBarButtonItem(customView: leftView)
        if #available(iOS 11, *) {
            self.navigationItem.leftBarButtonItems = [leftItem]
        } else {
            // 用于消除左边空隙，要不然按钮顶不到最左边
            let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            leftSpace.width = -20
            self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        }
    }
}

extension FzrNavigationController {
    private struct AssociatedKeys {
        static var fzr_barBackgroundColor: Void?
        static var fzr_barTintColor:  Void?
    }
    
    var fzr_barBackgroundColor : UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fzr_barBackgroundColor) as? UIColor ?? UIColor.red
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fzr_barBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            let image = UIImage.imageWithColor(fzr_barBackgroundColor)
            self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    var fzr_barTintColor : UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fzr_barTintColor) as? UIColor ?? UIColor.red
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fzr_barTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.navigationBar.tintColor = fzr_barTintColor
        }
    }
}
