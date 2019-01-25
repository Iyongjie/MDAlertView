//
//  ViewController.swift
//  MDAlertView
//
//  Created by 李永杰 on 2019/1/25.
//  Copyright © 2019 Y了个J. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("弹出", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        view.addSubview(button)
        
    }

    @objc func clickAction() {
        let alert = MDAlertView.init(CGSize(width: 300, height: 400),true)
        alert.customUI { (contentView, contentBackgroundImageView, closeButton) in
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
        }
        alert.tapToDismiss = false
        alert.cornerRadius = 30
        alert.show()
    }

}

