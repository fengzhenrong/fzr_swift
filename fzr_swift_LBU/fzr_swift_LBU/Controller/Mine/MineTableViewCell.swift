//
//  MineTableViewCell.swift
//  fzr_swift_LBU
//
//  Created by feng zhenrong on 2020/6/27.
//  Copyright © 2020 feng zhenrong. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class MineTableViewCell: UITableViewCell,Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUI()
        self.layoutConstraints()
        
    }
    
//    func setModel(_ model: [String: String]) -> Void {
//        self.titleLabel.text = model["title"] ?? ""
//        self.mineimageView.image = UIImage(named: model["icon"] ?? "")
//    }
    
    var mode : Dictionary<String, String>? {
        didSet {
            guard let mode = mode else { return }
            self.titleLabel.text = mode["title"] ?? ""
            self.mineimageView.image = UIImage(named: mode["icon"] ?? "")
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private var mineimageView : UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private var lineLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        return label
    }()
}

extension MineTableViewCell {
    
    /// 添加视图
    func buildUI() -> Void {
        self.contentView .addSubview(self.mineimageView)
        self.contentView .addSubview(self.titleLabel)
        self.contentView .addSubview(self.lineLabel)
    }
    
    /// 布局
    func layoutConstraints() -> Void {
        self.mineimageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.mineimageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        self.lineLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}
