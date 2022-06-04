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
           animationAmount += 1
        }
        .padding(50)
        .background(.orange)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
//        .animation(.interpolatingSpring(stiffness: 50.0, damping: 1.0), value: animationAmount)
        .animation(.easeInOut(duration: 2.0), value: animationAmount)
}
struct CustomizingAnimationsSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingAnimationsSwiftUI()
    }
  }
}


//3:16
