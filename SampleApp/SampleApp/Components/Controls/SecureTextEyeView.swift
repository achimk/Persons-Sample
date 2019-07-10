//
//  SecureTextEyeView.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

protocol SecureTextEyeViewDelegate: class {
    func secureTextEyeViewDidOpenEye(_ view: SecureTextEyeView)
    func secureTextEyeViewDidCloseEye(_ view: SecureTextEyeView)
}

final class SecureTextEyeView: UIView {
    
    enum EyeState {
        case open, closed
        
        func `switched`() -> EyeState {
            switch self {
            case .open:
                return .closed
            case .closed:
                return .open
            }
        }
    }
    
    weak var delegate: SecureTextEyeViewDelegate?
    
    var eyeState: EyeState = .closed {
        didSet {
            setupEyeImage(for: eyeState)
        }
    }
    
    private var eyeButton = UIButton(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupEye()
        setupEyeImage(for: eyeState)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupEye()
        setupEyeImage(for: eyeState)
    }
    
    static func `default`() -> SecureTextEyeView {
        return SecureTextEyeView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    
    private func setupEye() {
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(eyeButton)
        
        eyeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        eyeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        eyeButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        eyeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        eyeButton.addTarget(self, action: #selector(eyeButtonClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    private func setupEyeImage(for state: EyeState) {
        
        switch state {
        case .open:
            eyeButton.setImage(UIImage(named: "visibilityOn"), for: .normal)
        case .closed:
            eyeButton.setImage(UIImage(named: "visibilityOff"), for: .normal)
        }
    }
    
    // MARK: - Action Handling
    
    @objc private func eyeButtonClicked(_ sender: Any) {
        eyeState = eyeState.switched()
        
        switch eyeState {
        case .open:
            delegate?.secureTextEyeViewDidOpenEye(self)
        case .closed:
            delegate?.secureTextEyeViewDidCloseEye(self)
        }
    }
}
