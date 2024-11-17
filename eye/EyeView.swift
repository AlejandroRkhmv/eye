//
//  eyeView.swift
//  eye
//
//  Created by Александр Рахимов on 25.08.2024.
//

import UIKit

class EyeView: UIView {
    
    private let irisView = UIView()
    private let pupilView = UIView()
    private let whitePupilView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        irisView.backgroundColor = .white
        irisView.layer.borderColor = UIColor.black.cgColor
        irisView.layer.borderWidth = 3
        irisView.layer.cornerRadius = irisView.frame.width / 2
        addSubview(irisView)
        
        pupilView.backgroundColor = .black
        addSubview(pupilView)
        
        whitePupilView.backgroundColor = .white
        pupilView.addSubview(whitePupilView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        irisView.frame = bounds
        irisView.layer.cornerRadius = irisView.frame.width / 2
        
        let pupilSize = irisView.bounds.width * 0.6
        pupilView.frame = CGRect(x: 0, y: 0, width: pupilSize, height: pupilSize)
        pupilView.center = irisView.center
        pupilView.layer.cornerRadius = pupilSize / 2
        
        let whitePupilSize = pupilSize * 0.4
        whitePupilView.frame = CGRect(x: pupilView.bounds.midX, y: pupilView.bounds.minY + 3, width: whitePupilSize, height: whitePupilSize)
        whitePupilView.layer.cornerRadius = whitePupilSize / 2
    }
    
    func movePupil(to point: CGPoint) {
        let eyeCenter = irisView.center
        let eyeRadius = irisView.bounds.width / 2 - pupilView.bounds.width / 2
        
        // Преобразую координаты точки в координаты внутри глазного яблока
        let dx = point.x - eyeCenter.x
        let dy = point.y - eyeCenter.y
        let distance = sqrt(dx * dx + dy * dy)
        
        let constrainedPoint: CGPoint
        
        if distance > eyeRadius {
            let scale = eyeRadius / distance
            constrainedPoint = CGPoint(
                x: eyeCenter.x + dx * scale,
                y: eyeCenter.y + dy * scale
            )
        } else {
            constrainedPoint = CGPoint(
                x: eyeCenter.x + dx,
                y: eyeCenter.y + dy
            )
        }
        
        pupilView.center = constrainedPoint
    }
    
    func resetPupilPosition() {
        pupilView.center = irisView.center
    }
    
}
