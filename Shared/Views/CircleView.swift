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
    let animationDuration: Double = 1
    let opacityDuringAnimation: Double = 1
    let opacityWithoutAnimation: Double = 0
    let blurDuringAnimation: Double = 0
    let blurWithoutAnimation: Double = 10
    let scaleEffectDuringAnimation: Double = 1
    let scaleEffectWithoutAniation: Double = 0.5
    
    let backgroundCircleSize: Double = 260
    let defaultLineWidth: Double = 40
    
    var body: some View {
        ZStack {
          Circle()
            .stroke(.gray.opacity(ShapeOpacity), lineWidth: defaultLineWidth)
            .frame(width: backgroundCircleSize, height: backgroundCircleSize, alignment: .center)
          Circle()
            .stroke(.gray.opacity(ShapeOpacity), lineWidth: defaultLineWidth * 2)
            .frame(width: backgroundCircleSize, height: backgroundCircleSize, alignment: .center)
        }
        .blur(radius: isAnimating ? blurDuringAnimation : blurWithoutAnimation)
        .opacity(isAnimating ? opacityDuringAnimation : opacityWithoutAnimation)
        .scaleEffect(isAnimating ? scaleEffectDuringAnimation : scaleEffectWithoutAniation)
        .animation(.easeOut(duration: animationDuration), value: isAnimating)
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
