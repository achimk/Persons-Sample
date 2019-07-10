//
//  ScrollViewKeyboardController.swift
//  SampleApp
//
//  Created by Joachim Kret on 10/07/2019.
//  Copyright © 2019 Joachim Kret. All rights reserved.
//

import Foundation
import UIKit

final class ScrollViewKeyboardController {
    
    private var initialContentBottomInset: CGFloat = 0
    private var initialScrollIndicatorBottomInset: CGFloat = 0
    
    var scrollView: UIScrollView? {
        
        willSet {
            
            guard scrollView != nil else {
                return
            }
            
            removeKeyboardWillHideObserver()
            removeKeyboardWillShowObserver()
        }
        
        didSet {
            
            guard let scrollView = scrollView else {
                return
            }
            
            initialContentBottomInset = scrollView.contentInset.bottom
            initialScrollIndicatorBottomInset = scrollView.scrollIndicatorInsets.bottom
            
            addKeyboardWillShowObserver()
            addKeyboardWillHideObserver()
        }
    }
    
    deinit {
        removeKeyboardWillShowObserver()
        removeKeyboardWillHideObserver()
    }
    
    private var center: NotificationCenter {
        return NotificationCenter.default
    }
    
    private var keyboardWillShowObserver: Any?
    private var keyboardWillHideObserver: Any?
    
    private func addKeyboardWillShowObserver() {
        keyboardWillShowObserver = center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let scrollView = self?.scrollView, let initialContentBottomInset = self?.initialContentBottomInset, let initialScrollIndicatorBottomInset = self?.initialScrollIndicatorBottomInset else { return }
            
            if let userInfo = notification.userInfo {
                let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                
                let rect = scrollView.superview?.convert(scrollView.frame, to: UIScreen.main.coordinateSpace) ?? .zero
                let offset = rect.intersection(frameEnd).height
                
                scrollView.contentInset.bottom = offset + initialContentBottomInset
                scrollView.scrollIndicatorInsets.bottom = offset + initialScrollIndicatorBottomInset
            }
        }
    }
    
    private func removeKeyboardWillShowObserver() {
        if let keyboardWillShowObserver = keyboardWillShowObserver {
            center.removeObserver(keyboardWillShowObserver)
        }
    }
    
    private func addKeyboardWillHideObserver() {
        keyboardWillHideObserver = center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let scrollView = self?.scrollView, let initialContentBottomInset = self?.initialContentBottomInset, let initialScrollIndicatorBottomInset = self?.initialScrollIndicatorBottomInset else { return }
            
            scrollView.contentInset.bottom = initialContentBottomInset
            scrollView.scrollIndicatorInsets.bottom = initialScrollIndicatorBottomInset
        }
    }
    
    private func removeKeyboardWillHideObserver() {
        if let keyboardWillHideObserver = keyboardWillHideObserver {
            center.removeObserver(keyboardWillHideObserver)
        }
    }
}
