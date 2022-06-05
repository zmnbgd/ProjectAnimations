//
//  AnimatingBindings.swift
//  Animations
//
//  Created by Marko Zivanovic on 5.6.22..
//

import SwiftUI

struct AnimatingBindings: View {
    
    @State private var animationAmount = 1.0
    
    
    var body: some View {
        print(animationAmount)
        
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
                
            Spacer()
            
            Button("Tap me") {
                animationAmount += 1
                
            }
            .padding(50)
            .background(.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct AnimatingBindings_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingBindings()
    }
}
