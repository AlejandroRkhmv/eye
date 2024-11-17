//
//  ViewController.swift
//  eye
//
//  Created by Александр Рахимов on 08.08.2024.
//

import UIKit

enum SquareState {
    
    case noMoving
    case bottom
    case center
    case top
    case belowTop
    
}

class ViewController: UIViewController {
    
    private let eyeViewL = EyeView()
    private let eyeViewR = EyeView()
    
    private let draggableSquare = UIView()
    private var isDraggingSquare = false
    
    private var state: SquareState = .noMoving {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEyeViews()
        setupSquareView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutEyeViews()
    }
    
    private func layoutEyeViews() {
        
        let eyeWidth: CGFloat = 50.0
        eyeViewL.frame = CGRect(x: (view.frame.width - eyeWidth) / 2.0 - 30.0,
                                y: (view.frame.height - eyeWidth) / 2.0,
                               width: eyeWidth, height: eyeWidth)
        
        eyeViewR.frame = CGRect(x: (view.frame.width - eyeWidth) / 2.0 + 30.0,
                                y: (view.frame.height - eyeWidth) / 2.0,
                               width: eyeWidth, height: eyeWidth)
    }
    
    private func setupEyeViews() {
        view.addSubview(eyeViewL)
        view.addSubview(eyeViewR)
    }
    
    private func setupSquareView() {
        let squareWidth: CGFloat = 25.0
        draggableSquare.frame = CGRect(x: view.bounds.size.width / 2 - draggableSquare.bounds.size.width / 2, y: 800, width: squareWidth, height: squareWidth)
        draggableSquare.backgroundColor = .purple
        view.addSubview(draggableSquare)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        draggableSquare.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view) // Позиция относительно вьюхи
        
        draggableSquare.center = point // Обновляю центр квадрата, сильно не запариваясь
        print("\(point.x)", "\(point.y)")

        if gesture.state == .ended {
            // Возвращаю зрачок в центр
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.eyeViewL.resetPupilPosition()
                self?.eyeViewR.resetPupilPosition()
            }
        } else if gesture.state == .changed {
            // Перемещаем зрачок за квадратом
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self else { return }
                let pointInEyeViewL = gesture.location(in: eyeViewL) // Позиция квадрата относительно глаза
                eyeViewL.movePupil(to: pointInEyeViewL)
                let pointInEyeViewR = gesture.location(in: eyeViewR) // Позиция квадрата относительно глаза
                eyeViewR.movePupil(to: pointInEyeViewR)
            }
        }
    }
    
    
}
