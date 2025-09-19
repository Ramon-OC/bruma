//
//  ScratchWordView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI

struct ScratchWordView: View {
    @Binding var points: [CGPoint]
    @Binding var isScratchingEnabled: Bool
    
    var keyword: String = ""
    var keywordAFI: String = ""
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mediumGreen)
                    .frame(width: 370, height: 250)
                
                Image(systemName: "fish.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mediumBlue)
                    .frame(width: 370, height: 250)
                
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
                : nil // No gesture if disabled
            )
        }
    }
}
