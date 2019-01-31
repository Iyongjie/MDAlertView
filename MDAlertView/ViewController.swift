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
        let alert = HomeAlertView.init(CGSize(width: 300, height: 400))
        alert.configUI()
        alert.tapToDismiss = true
        alert.cornerRadius = 100
        alert.delegate = self as HomeAlertViewDelegate
        alert.show()
    }

}

extension ViewController: HomeAlertViewDelegate {
    func clickHomeAlert(_ index: NSInteger) {
        print("点击了\(index)")
    }
}
