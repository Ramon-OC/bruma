//
//  FlexibleImage.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI

struct FlexibleImage: View {
    let name: String

    var body: some View {
        if UIImage(named: name) != nil {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        } else {
            Image(systemName: name)
        }
    }
}
