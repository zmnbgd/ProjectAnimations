//
//  CreatingImplicitAnimations.swift
//  Animations
//
//  Created by Marko Zivanovic on 4.6.22..
//

import SwiftUI

struct CreatingImplicitAnimations: View {
    
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap me") {
           animationAmount += 1
        }
        .padding(50)
        .background(.orange)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
}

struct CreatingImplicitAnimations_Previews: PreviewProvider {
    static var previews: some View {
        CreatingImplicitAnimations()
    }
  }
}
