//
//  CreatingExplicitAnimations.swift
//  Animations
//
//  Created by Marko Zivanovic on 5.6.22..
//

import SwiftUI

struct CreatingExplicitAnimations: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap me") {
            // do nothing
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
            animationAmount += 360
        }
    }
        .padding(50)
        .background(.cyan)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct CreatingExplicitAnimations_Previews: PreviewProvider {
    static var previews: some View {
        CreatingExplicitAnimations()
    }
}
