//
//  MDAlertView.swift
//  MDAlertView
//
//  Created by 李永杰 on 2019/1/25.
//  Copyright © 2019 Y了个J. All rights reserved.
//

import UIKit
import Foundation
import Spring

private let ScreenW = UIScreen.main.bounds.size.width
private let ScreenH = UIScreen.main.bounds.size.height

/// 配置alert UI
typealias ConfigAlertUIClosure = (_ contentBackgroundView: UIView, _ contentViewBackgroundImageView: UIImageView, _ closeButton: UIButton) -> Void

class MDAlertView: UIView {
    // MARK: 公开属性
    var configAlertUIClosure: ConfigAlertUIClosure?
    var tapToDismiss: Bool = false {
        didSet {
            if tapToDismiss {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
                backgroundView?.addGestureRecognizer(tap)
            }
        }
    }
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            contentView?.layer.cornerRadius = cornerRadius
            contentView?.layer.masksToBounds = true
        }
    }
    
    // MARK: 私有属性
    private var backgroundView: UIView?
    private var contentView: SpringView?
    private var contentBackgroundImageView: UIImageView?
    private var closeButton: SpringButton?
    private var contentViewSize: CGSize?
    
    // MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init( _ contentSize: CGSize, _ tapToDismiss: Bool) {
        self.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH))
        contentViewSize = contentSize
        configAlertUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 公开函数
    
    /// 弹出
    func show() {
        let window:UIWindow = (UIApplication.shared.delegate?.window ?? nil)!
        self.alpha = 0
        window.addSubview(self)
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                window.bringSubviewToFront(self)
            }
        }
        configAnimation()
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    /// 隐藏
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    
    /// 自定义视图
    ///
    /// - Parameter closure: 闭包
    func customUI(_ closure: @escaping ConfigAlertUIClosure) {
        configAlertUIClosure = closure
        configAlertUIClosure!(contentView!,contentBackgroundImageView!,closeButton!)
    }
    
    // MARK: 私有函数
    /// 配置视图
    private func configAlertUI() {
        self.backgroundColor = .clear
        
        backgroundView = UIView(frame: self.frame)
        backgroundView?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        self.addSubview(backgroundView!)
        
        contentView = SpringView(frame: CGRect(x: 0, y: 0, width: (contentViewSize?.width)!, height: (contentViewSize?.height)!))
        contentView?.center = (backgroundView?.center)!
        contentView?.backgroundColor = .white
        backgroundView?.addSubview(contentView!)
        contentView?.layer.cornerRadius = cornerRadius
        contentView?.layer.masksToBounds = true
        
        contentBackgroundImageView = UIImageView(frame: (contentView?.bounds)!)
        contentBackgroundImageView?.isUserInteractionEnabled = true
        contentBackgroundImageView?.contentMode = .scaleAspectFill
        contentView?.addSubview(contentBackgroundImageView!)
        
        closeButton = SpringButton()
        closeButton?.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        backgroundView?.addSubview(closeButton!)
    }
    
    /// 配置动画,根据实际情况调整
    private func configAnimation() {
        let force: CGFloat = 1
        let duration: CGFloat = 1
        let delay: CGFloat = 0
        let damping: CGFloat = 0.7
        let velocity: CGFloat = 0.7
        contentView?.force = force
        contentView?.duration = duration
        contentView?.delay = delay
        contentView?.damping = damping
        contentView?.velocity = velocity
        contentView?.animation = "pop"
        contentView?.curve = "spring"
        contentView?.animate()
        
        closeButton?.animation = "pop"
        closeButton?.curve = "spring"
        closeButton?.animate()
    
    }
}
