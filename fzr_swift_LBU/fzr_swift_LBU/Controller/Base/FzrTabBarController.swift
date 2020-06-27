//
//  FzrTabBarController.swift
//  fzr_swift_LBU
//
//  Created by feng zhenrong on 2020/6/7.
//  Copyright © 2020 feng zhenrong. All rights reserved.
//

import UIKit
import SideMenu

class FzrTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background
        
        //setValue(FzrTabBar(), forKeyPath: "tabBar")
        addChilder(child: HomeViewController(), title: "主页", image: "tab_home", index: 0)
        addChilder(child: CategoryViewController(), title: "分类", image: "tab_class", index: 1)
        addChilder(child: BookViewController(), title: "书架", image: "tab_book", index: 0)
        addChilder(child: MineViewController(), title: "我的", image: "tab_mine", index: 0)
        
        // Do any additional setup after loading the view.
    }
    
    /// 底部导航栏添加页面
    ///
    /// 添加页面标题，图标，选中图标
    ///
    /// - Parameter child:页面
    /// - Parameter title:页面标题
    /// - Parameter image:底部图标
    /// - Parameter index:页面索引
    ///
    /// - Note:参数全部需要传入
    ///
    /// - Returns:无
    
    func addChilder(child:UIViewController, title:String, image:String, index:Int) {
        let navigation = FzrNavigationController(rootViewController: child)
        child.title=nil
        child.tabBarItem.tag=index
        child.tabBarItem.image=UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        let image_c = String(format:"%@_S",image)
        child.tabBarItem.selectedImage=UIImage(named: image_c)?.withRenderingMode(.alwaysOriginal)
        if UIDevice.current.userInterfaceIdiom == .phone {
            child.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        let attributeString = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.gray]
        let attributeString_c = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.green]
        navigation.tabBarItem.setTitleTextAttributes(attributeString, for: UIControl.State.normal)
        navigation.tabBarItem.setTitleTextAttributes(attributeString_c, for: UIControl.State.selected)
        
        
        self.addChild(navigation)
    }

}

extension FzrTabBarController {
    
    private func setupSideMenu() {
        // 定义一个侧栏菜单
        let menu = SideMenuNavigationController(rootViewController:LeftTableViewController())
        
        SideMenuManager.default.leftMenuNavigationController = menu
        guard let topview = getTopMostViewController(base: self) else {
            NSLog("======获取顶部视图失败=======")
            return
        }
        SideMenuManager.default.addPanGestureToPresent(toView: topview.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: topview.view)
        
        menu.settings = makeSettings()
    }
    public func pushSideMenu() -> () {
        
        setupSideMenu()
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
        completion: nil)
    }
    
    private func selectedPresentationStyle(_ index: Int = 1) -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return modes[index]
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    func getTopMostViewController(base: UIViewController? = sceneDelegate?.rootVC) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}

//extension FzrTabBarController {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        guard let select = selectedViewController else { return .lightContent }
//        return select.preferredStatusBarStyle
//    }
//}
