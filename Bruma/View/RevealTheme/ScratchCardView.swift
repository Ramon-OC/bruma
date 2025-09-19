//
//  ScratchWordView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI
struct ScratchWordView: View {
    @ObservedObject var motion = RoleCardMotionManager()
    
    @Binding var points: [CGPoint]
    @Binding var isScratchingEnabled: Bool
    
    var keyword: String = ""
    var keywordAFI: String = ""
    
    var width: CGFloat = 370
    var height: CGFloat = 250
    
    var body: some View {
        ZStack {
            // Capa base (la que se ve antes de rascar)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mediumGreen)
                    .frame(width: width, height: height)
                
                Image(systemName: "fish.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
                
                // Efecto topográfico en la capa base
                Image(.topographic)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white.opacity(0.3), .white.opacity(0.1), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: width, height: height)
                    .mask {
                        reflection(blur: 40)
                    }
                    .clipped()
                
                // Reflejo adicional para el efecto de luz
                reflection(blur: 60)
                    .opacity(0.4)
            }
            
            // Capa superior (la que se revela al rascar)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mediumBlue)
                    .frame(width: width, height: height)
                
                // Patrón topográfico de fondo en la capa revelada
                Image(.topographic)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.white.opacity(0.08))
                    .frame(width: width, height: height)
                
                VStack(alignment: .center, spacing: 30) {
                    Text(keyword)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(keywordAFI)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .italic()
                }
                
                // Efecto topográfico en la capa revelada
                Image(.topographic)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white.opacity(0.2), .blue.opacity(0.3), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: width, height: height)
                    .mask {
                        reflection(blur: 50)
                    }
                    .clipped()
                
                // Reflejo para el efecto de luz
                reflection(blur: 80)
                    .opacity(0.3)
            }
            .mask(
                Path { path in
                    path.addLines(points)
                }
                .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
            )
            .gesture(
                isScratchingEnabled ?
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        points.append(value.location)
                        let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
                        impactFeedback.impactOccurred()
                    })
                    .onEnded({ _ in
                        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
                        impactFeedback.impactOccurred()
                    })
                : nil
            )
        }
        .frame(width: width, height: height)
        .mask(RoundedRectangle(cornerRadius: 20))
        // Efectos de movimiento solo cuando no está rascando
        .rotation3DEffect(
            .degrees(isScratchingEnabled ? 0 : motion.pitch),
            axis: (x: 1, y: 0, z: 0)
        )
        .rotation3DEffect(
            .degrees(isScratchingEnabled ? 0 : motion.roll),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeOut(duration: 0.2), value: motion.pitch)
        .animation(.easeOut(duration: 0.2), value: motion.roll)
        .animation(.easeInOut(duration: 0.3), value: isScratchingEnabled)
        .onTapGesture {
            if !isScratchingEnabled {
                withAnimation(.easeInOut(duration: 0.3)) {
                    motion.calibrate()
                }
            }
        }
    }
    
    // Función para crear el efecto de reflejo/luz
    func reflection(blur: CGFloat) -> some View {
        Circle()
            .foregroundStyle(.white)
            .frame(width: width * 0.8, height: height * 0.8)
            .offset(
                x: isScratchingEnabled ? 0 : motion.roll * calculateOffsetMultiplier(),
                y: isScratchingEnabled ? 0 : motion.pitch * calculateOffsetMultiplier()
            )
            .blur(radius: blur)
            .opacity(
                isScratchingEnabled ? 0.1 :
                min(sqrt(motion.pitch * motion.pitch + motion.roll * motion.roll) / 15, 0.6)
            )
    }
    
    // Calcula el multiplicador del offset para que el círculo no salga de la tarjeta
    private func calculateOffsetMultiplier() -> CGFloat {
        let maxOffsetX = (width / 2) - 20
        let maxOffsetY = (height / 2) - 20
        
        let multiplierX = maxOffsetX / 15
        let multiplierY = maxOffsetY / 15
        
        return min(multiplierX, multiplierY)
    }
}
