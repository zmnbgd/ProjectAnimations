//
//  ShowingHidingViewsTransitions.swift
//  Animations
//
//  Created by Marko Zivanovic on 7.6.22..
//

import SwiftUI

struct ShowingHidingViewsTransitions: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                isShowingRed.toggle()
            }
        }
            if isShowingRed {
            Rectangle()
                .fill(.red)
                .frame(width: 200, height: 200)
                //.transition(.scale)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ShowingHidingViewsTransitions_Previews: PreviewProvider {
    static var previews: some View {
        ShowingHidingViewsTransitions()
    }
}
