//
//  GradientExtensions.swift
//  PYWaitingViewExample
//
//  Created by Pierre Yao on 03/09/2018.
//  Copyright © 2018 Pierre Yao. All rights reserved.
//

import UIKit

extension CAGradientLayer {
	
	func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
		let layer = CAGradientLayer()
		layer.frame = bounds
		layer.startPoint = CGPoint(x: 0.0, y: 0.5)
		layer.endPoint = CGPoint(x: 1.0, y: 0.5)
		layer.colors = [UIColor.init("#4FAFD1", defaultColor: .white).cgColor, UIColor.init("#67DCAC", defaultColor: .white).cgColor]
		return layer
	}
}
