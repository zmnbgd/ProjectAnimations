//
//  CustomizingAnimationsSwiftUI.swift
//  Animations
//
//  Created by Marko Zivanovic on 4.6.22..
//

import SwiftUI

struct CustomizingAnimationsSwiftUI: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap me") {
           //animationAmount += 1
        }
        .padding(50)
        .background(.orange)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
        Circle()
            .stroke(.orange)
            .scaleEffect(animationAmount)
            .opacity(2 - animationAmount)
            .animation(
                .easeInOut(duration: 1.0).repeatForever(autoreverses: false),
                value: animationAmount
            )
        )
        
        .onAppear {
            animationAmount = 2
        }
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
//        .animation(.interpolatingSpring(stiffness: 50.0, damping: 1.0), value: animationAmount)
    }
}
struct CustomizingAnimationsSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingAnimationsSwiftUI()
    }
  }

