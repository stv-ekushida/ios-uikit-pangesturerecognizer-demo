//
//  ViewController.swift
//  ios-uikit-pangesturerecognizer-demo
//
//  Created by Kushida　Eiji on 2017/05/20.
//  Copyright © 2017年 Kushida　Eiji. All rights reserved.
//

import UIKit

extension Selector {
    static let handlePan = #selector(ViewController.handlePan(gestureRecognizer:))
}

final class ViewController: UIViewController {

    @IBOutlet weak var dragview: UIView!
    var viewDragging = false
    var previousTouchPoint: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        addPanGesture()
    }

    /// パンジェスチャーの登録
    private func addPanGesture() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                          action: .handlePan)
        dragview.addGestureRecognizer(panGestureRecognizer)
    }

    func handlePan (gestureRecognizer: UIPanGestureRecognizer) {

        let touchPoint = gestureRecognizer.location(in: self.view)

        let draggedView = gestureRecognizer.view!

        if gestureRecognizer.state == .began {
            print("began")

            let dragStartPoint = gestureRecognizer.location(in: draggedView)

            if dragStartPoint.y < 100 {

                viewDragging = true
                previousTouchPoint = touchPoint
            }

        } else if gestureRecognizer.state == .changed && viewDragging {
            print("changed")

            let yOffset = previousTouchPoint.y - touchPoint.y

            draggedView.center = CGPoint(x: draggedView.center.x,
                                         y: draggedView.center.y - yOffset)
            previousTouchPoint = touchPoint

        }else if gestureRecognizer.state == .ended && viewDragging {

            print("ended")
            viewDragging = false
        }
    }
}

