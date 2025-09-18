//
//  RoleCardMotionManager.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import Foundation
import CoreMotion

// MARK: - MotionManager
class RoleCardMotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var isCalibrated = false
    
    private var pitchOffset: Double = 0.0
    private var rollOffset: Double = 0.0
    
    private let maxRotation: Double = 15.0 // Grados máximos de inclinación
    
    func calibrate() {
        pitchOffset = currentRawPitch
        rollOffset = currentRawRoll
        isCalibrated = true
    }
    
    private var currentRawPitch: Double = 0.0
    private var currentRawRoll: Double = 0.0
    
    init() {
        startMotionUpdates()
    }
    
    func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }

        motionManager.deviceMotionUpdateInterval = 1 / 60
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self, let motion = motion, error == nil else { return }

            DispatchQueue.main.async {
                self.currentRawPitch = motion.attitude.pitch * 30
                self.currentRawRoll = motion.attitude.roll * 30

                // Calibración automática en la primera lectura
                if !self.isCalibrated {
                    self.calibrate()
                }

                // Aplicar offset y limitar el rango
                let rawPitch = self.currentRawPitch - self.pitchOffset
                let rawRoll = self.currentRawRoll - self.rollOffset

                // Limitar el movimiento para evitar volteo completo
                self.pitch = max(-self.maxRotation, min(self.maxRotation, rawPitch))
                self.roll = max(-self.maxRotation, min(self.maxRotation, rawRoll))
            }
        }
    }

    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
