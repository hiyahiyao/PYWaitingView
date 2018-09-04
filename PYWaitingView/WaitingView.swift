//
//  WaitingView.swift
//  Tontine
//
//  Created by Pierre Yao on 29/11/2016.
//  Copyright © 2016 Pierre Yao. All rights reserved.
//

import Foundation
import UIKit

let kOpacity = "opacity"
let kAnimateOpacity = "animateOpacity"

public class PYWaitingView: UIView {
    
    private var illustrationContainer = UIImageView()
	public var illustrations = [UIImage]()
	private var timer: Timer?
	private var currentIndex = 0
	// The time interval between each image flip
	public var imageFlipInterval: TimeInterval = 1
	// The time interval for each image pulse
	public var imagePulseInterval: TimeInterval = 1
	
    public override init(frame: CGRect) {
        super.init(frame: frame)
        illustrationContainer.contentMode = .scaleAspectFit
        illustrationContainer.tintColor = .white
        addSubview(illustrationContainer)
		illustrationContainer.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			illustrationContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
			illustrationContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
			illustrationContainer.widthAnchor.constraint(equalToConstant: 50),
			illustrationContainer.heightAnchor.constraint(equalToConstant: 50)
		])
    }
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    //MARK: - Actions
	
	/**
	Launch waiting view animation
	*/
    private func launchAnimation() {
		// We do this to avoid waiting "imageFlipInterval" before seeing an image
		flipImage()
        timer = Timer.scheduledTimer(timeInterval: imageFlipInterval, target:self, selector: #selector(flipImage), userInfo: nil, repeats: true)
    }
	
	/**
	Change "illustrationContainer" content with an image contains in "illustrations"
	*/
	@objc private func flipImage() {
        if currentIndex == illustrations.count {
            currentIndex = 0
        }
        
        let currentImage = illustrations[currentIndex]
       	illustrationContainer.image = currentImage
        let pulseAnimation = CABasicAnimation(keyPath: kOpacity)
        pulseAnimation.duration = imagePulseInterval
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.greatestFiniteMagnitude
        illustrationContainer.layer.add(pulseAnimation, forKey: kAnimateOpacity)
        currentIndex += 1
    }
	
	/**
	Show waiting view
	*/
    public func show() {
		self.launchAnimation()
        alpha = 0
		UIView.animate(withDuration: -1) {
			self.alpha = 1
		}
    }
	
	/**
	Stop waiting view
	*/
    public func stop() {
		timer?.invalidate()
		UIView.animate(withDuration: -1, animations: {
			self.alpha = 0
		}) { finished in
			self.removeFromSuperview()
		}
    }
}
