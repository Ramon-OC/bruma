//
//  Fish.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//

import SwiftUI
import CoreMotion

struct FishEyeView: View {
    @StateObject private var motionManager = MotionManager()
    
    // Configuración del ojo
    private let eyeRadius: CGFloat = 30
    private let pupilRadius: CGFloat = 8
    
    var body: some View {
        ZStack {
            // Imagen del pez
            Image("FishImage")
                .resizable()
                .scaledToFit()
            
            // Ojo del pez
            EyeView(
                pupilOffset: motionManager.pupilOffset,
                eyeRadius: eyeRadius,
                pupilRadius: pupilRadius
            )
            .offset(x: 120, y: -10) // Ajusta según la posición del ojo en tu imagen
        }
        .onAppear {
            motionManager.startMotionUpdates(eyeRadius: eyeRadius, pupilRadius: pupilRadius)
        }
        .onDisappear {
            
            motionManager.stopMotionUpdates()
        }
    }
}

struct EyeView: View {
    let pupilOffset: CGPoint
    let eyeRadius: CGFloat
    let pupilRadius: CGFloat
    
    var body: some View {
        ZStack {
            // Fondo blanco del ojo
            Circle()
                .fill(Color.white)
                .frame(width: eyeRadius * 2, height: eyeRadius * 2)
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
            
            // Pupila
            Circle()
                .fill(Color.black)
                .frame(width: pupilRadius * 4, height: pupilRadius * 4)
                .offset(x: pupilOffset.x, y: pupilOffset.y)
                .animation(.easeOut(duration: 0.1), value: pupilOffset)
        }
    }
}

#Preview("Fish with Mobile Eye") {
    FishEyeView()
}
