//
//  ContentView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                FishEyeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("Pez con Ojo Interactivo")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
}
