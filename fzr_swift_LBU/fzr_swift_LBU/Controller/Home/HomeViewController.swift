//
//  HomeViewController.swift
//  fzr_swift_LBU
//
//  Created by feng zhenrong on 2020/6/7.
//  Copyright © 2020 feng zhenrong. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    lazy var pushbtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("下一页", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.backgroundColor=UIColor.red
        btn.addTarget(self, action: #selector(nextpage), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="首页"
        self.view.backgroundColor = UIColor.white
        self.pushbtn.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        self.view.addSubview(self.pushbtn)
        self.setUpNav()
        NSLog("====你好=====")
        // Do any additional setup after loading the view.
    }
    

    
    
    @objc func nextpage() -> Void {
        self.navigationController?.pushViewController(ComicViewController(), animated: false)
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

extension HomeViewController {
    func setUpNav() -> Void {
        
//        UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:target action:action];
        // 用于消除左边空隙，要不然按钮顶不到最左边
//        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        leftSpace.width = -20
//        let leftItem = UIBarButtonItem.init(image: UIImage(named: "mine_author"), target: self, action: #selector(leftAction))
        let leftItem = UIBarButtonItem(image: UIImage(named: "mine_author"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftAction))
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0,left: -10,bottom: 0,right: 0)
    }
    
    @objc func leftAction() {
        guard let rootv = sceneDelegate?.rootVC else {
            NSLog("----noneroot------")
            return
        }
        
        rootv.pushSideMenu()
    } 
}

