//
//  HomeAlertView.swift
//  MDCarProjectSwift
//
//  Created by 李永杰 on 2019/1/29.
//  Copyright © 2019 于朝盼. All rights reserved.
//

import UIKit



@objc protocol HomeAlertViewDelegate {
    
    func clickHomeAlert(_ index: NSInteger)
}

private let ScreenW = UIScreen.main.bounds.size.width
private let ScreenH = UIScreen.main.bounds.size.height

class HomeAlertView: MDAlertView {
    
    weak var delegate: HomeAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func configUI() {
        self.customUI { (contentView, contentBackgroundImageView, closeButton) in
            // 调整位置，背景图片，颜色,关闭按钮
            
            // 配置contentView
            contentView.backgroundColor = .white
            contentBackgroundImageView.image = UIImage(named: "background.jpg")

            // 在contenView上添加子视图
            let title = UILabel(frame: CGRect(x: 0, y: 20, width: 300, height: 20))
            title.text = "你可以添加点别的"
            title.textAlignment = .center
            title.textColor = .red
            contentView.addSubview(title)

            let view = UIView(frame: CGRect(x: 0, y: 50, width: 100, height: 30))
            view.backgroundColor = .green
            contentView.addSubview(view)

            let view1 = UIView(frame: CGRect(x: 0, y: 120, width: 100, height: 30))
            view1.backgroundColor = .blue
            contentView.addSubview(view1)

            // 调整关闭按钮的位置,关闭按钮和contenView是平级的
            closeButton.frame = CGRect(x: contentView.center.x-25, y: contentView.frame.maxY + 20, width: 40, height: 40)
            closeButton.setImage(UIImage(named: "close"), for: .normal)
            
            // 添加个button
            // 调整关闭按钮的位置,关闭按钮和contenView是平级的
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: contentView.center.x-50, y: contentView.frame.size.height - 120, width: 140, height: 40)
            button.tag = 1002
            button.setTitle("我是新添加上的", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.addTarget(self, action: #selector(self.doSomeThing), for: .touchUpInside)
            contentView.addSubview(button)
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func doSomeThing( _ sender: UIButton) {
        guard delegate != nil else {
            return
        }
        delegate?.clickHomeAlert(sender.tag)
    }
}
