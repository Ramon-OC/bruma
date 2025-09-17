//
//  MotionManager.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private let manager = CMMotionManager()
    @Published var pupilOffset = CGPoint.zero
    
    private var maxMovementRadius: CGFloat = 0
    
    func startMotionUpdates(eyeRadius: CGFloat, pupilRadius: CGFloat) {
        maxMovementRadius = eyeRadius - pupilRadius - 2
        
        guard manager.isDeviceMotionAvailable else {
            print("Device motion no disponible")
            return
        }
        
        manager.deviceMotionUpdateInterval = 0.02 // 50 FPS
        
        manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let motion = motion, let self = self else { return }
            
            let gravity = motion.gravity
            
            // Convertir gravedad en offset de pupila
            let moveX = CGFloat(gravity.x) * self.maxMovementRadius
            let moveY = CGFloat(-gravity.y) * self.maxMovementRadius // Y invertido para naturalidad
            
            // Limitar movimiento al círculo del ojo
            let distance = sqrt(moveX * moveX + moveY * moveY)
            
            if distance <= self.maxMovementRadius {
                self.pupilOffset = CGPoint(x: moveX, y: moveY)
            } else {
                let ratio = self.maxMovementRadius / distance
                self.pupilOffset = CGPoint(
                    x: moveX * ratio,
                    y: moveY * ratio
                )
            }
        }
    }
    
    func stopMotionUpdates() {
        manager.stopDeviceMotionUpdates()
    }
}
