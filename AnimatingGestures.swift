//
//  AnimatingGestures.swift
//  Animations
//
//  Created by Marko Zivanovic on 6.6.22..
//

import SwiftUI

struct AnimatingGestures: View {
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(dragAmount)
            .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation {
                        // explicite animation
                    dragAmount = .zero
                    }
                }
            )
           // .animation(.spring(), value: dragAmount)
        // implicit ainmation
        
    }
}

struct AnimatingGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGestures()
    }
}
