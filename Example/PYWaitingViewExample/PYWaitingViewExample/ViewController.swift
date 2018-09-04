//
//  ViewController.swift
//  PYWaitingViewExample
//
//  Created by Pierre Yao on 03/09/2018.
//  Copyright © 2018 Pierre Yao. All rights reserved.
//

import UIKit
import PYWaitingView

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func showWaitingView(_ sender: Any) {
		let waitingView = WaitingView(frame: view.frame)
		waitingView.imageFlipInterval = 1
		waitingView.imagePulseInterval = 1
		let illustrations =  [UIImage(named: "collecte.png")?.withRenderingMode(.alwaysTemplate),
							  UIImage(named: "solidaire.png")?.withRenderingMode(.alwaysTemplate),
							  UIImage(named: "premium.png")?.withRenderingMode(.alwaysTemplate),
							  UIImage(named: "family.png")?.withRenderingMode(.alwaysTemplate)
		]
		waitingView.illustrations = illustrations as! [UIImage]
		view.addSubview(waitingView)
		waitingView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			waitingView.topAnchor.constraint(equalTo: view.topAnchor),
			waitingView.leftAnchor.constraint(equalTo: view.leftAnchor),
			waitingView.rightAnchor.constraint(equalTo: view.rightAnchor),
			waitingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
		waitingView.show()
		waitingView.backgroundColor = UIColor(patternImage: imageLayerForGradientBackground(bounds: CGRect(x: 0, y: 0, width: view.frame.width, height: 50)))
		
		// Hide the waiting view
		DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
			waitingView.stop()
		}
	}
	
	// Utils
	
	func imageLayerForGradientBackground(bounds : CGRect) -> UIImage {
		let layer = CAGradientLayer().gradientLayerForBounds(bounds: bounds)
		UIGraphicsBeginImageContext(layer.bounds.size)
		layer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
}

