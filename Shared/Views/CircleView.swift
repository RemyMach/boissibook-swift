//
//  CircleView.swift
//  boissibook
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import SwiftUI

struct CircleView: View {
    
    @State var ShapeOpacity: Double
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
          Circle()
                .stroke(.gray.opacity(ShapeOpacity), lineWidth: 40)
            .frame(width: 260, height: 260, alignment: .center)
          Circle()
                .stroke(.gray.opacity(ShapeOpacity), lineWidth: 80)
            .frame(width: 260, height: 260, alignment: .center)
        } //: ZSTACK
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
          isAnimating = true
        })
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
          CircleView(ShapeOpacity: 0.2)
        }
    }
}
