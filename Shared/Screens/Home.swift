//
//  Home.swift
//  boissibook
//
//  Created by Rémy Machavoine on 02/07/2022.
//

import SwiftUI

struct Home: View {
    @State private var textTitle: String = "Lire."
    @State private var textDescription: String = "Lire, c’est boire et manger. L’esprit qui ne lit pas maigrit comme le corps qui ne mange pas."
    @State private var imageOffset: CGSize = .zero
    @State private var isAnimating: Bool = false
    @State private var indicatorOpacity: Double = 1.0
    @State private var buttonOffset: CGFloat = 0
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @Binding var isOnboardingViewActive: Bool;
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
              // MARK: - HEADER
              Spacer()
              
              VStack(spacing: 0) {
                Text(textTitle)
                  .font(.system(size: 60))
                  .fontWeight(.heavy)
                  .foregroundColor(.black)
                  .transition(.opacity)
                  .id(textTitle)
                  
                
              Text(textDescription)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                  
              }// HEADER
              .opacity(isAnimating ? 1 : 0)
              .offset(y: isAnimating ? 0 : -40)
              .animation(.easeOut(duration: 1), value: isAnimating)
              // temporary
            
                // MARK: - CENTER
                ZStack {
                  CircleView(ShapeOpacity: 0.2)
                    .offset(x: imageOffset.width * -1)
                    .blur(radius: abs(imageOffset.width / 5))
                    .animation(.easeOut(duration: 1), value: imageOffset)
                  
                  Image("books-home-2")
                    .resizable()
                    .scaledToFit()
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.5), value: isAnimating)
                    .offset(x: imageOffset.width * 1.2, y: -15)
                    .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                    .gesture(
                      DragGesture()
                        .onChanged { gesture in
                          if abs(imageOffset.width) <= 150 {
                            imageOffset = gesture.translation
                            
                            withAnimation(.linear(duration: 0.25)) {
                              indicatorOpacity = 0
                              textTitle = "Lire."
                              textDescription = "Lire est le seul moyen de vivre plusieurs fois"
                            }
                          }
                        }
                        .onEnded { _ in
                          imageOffset = .zero
                          
                          withAnimation(.linear(duration: 0.25)) {
                            indicatorOpacity = 1
                            textTitle = "Lire."
                            textDescription = "Lire, c’est boire et manger. L’esprit qui ne lit pas maigrit comme le corps qui ne mange pas."
                          }
                        }
                    ) //: GESTURE
                    .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(
                  Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.black)
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                  , alignment: .bottom
                )
                Spacer()
                
            // FOOTER
                
                ZStack {
                  // PARTS OF THE CUSTOM BUTTON
                  
                  // 1. BACKGROUND (STATIC)
                  
                  Capsule()
                    .fill(Color.blue.opacity(0.2))
                  
                  Capsule()
                    .fill(Color.blue.opacity(0.2))
                    .padding(8)
                  
                  // 2. CALL-TO-ACTION (STATIC)
                  
                  Text("Ouvrir")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: 20)
                  
                  // 3. CAPSULE (DYNAMIC WIDTH)
                  
                  HStack {
                    Capsule()
                          .fill(.blue)
                      .frame(width: buttonOffset + 80)
                    
                    Spacer()
                  }
                  
                  // 4. CIRCLE (DRAGGABLE)
                  
                  HStack {
                    ZStack {
                      Circle()
                            .fill(.blue.opacity(0.2))
                      Circle()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                      Image(systemName: "chevron.right.2")
                        .font(.system(size: 24, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x: buttonOffset)
                    .gesture(
                      DragGesture()
                        .onChanged { gesture in
                          if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                            buttonOffset = gesture.translation.width
                          }
                        }
                        .onEnded { _ in
                          withAnimation(Animation.easeOut(duration: 0.4)) {
                            if buttonOffset > buttonWidth / 2 {
                              hapticFeedback.notificationOccurred(.success)
                              playSound(sound: "chimeup", type: "mp3")
                              buttonOffset = buttonWidth - 80
                                isOnboardingViewActive = false
                            } else {
                              hapticFeedback.notificationOccurred(.warning)
                              buttonOffset = 0
                            }
                          }
                        }
                    ) //: GESTURE
                    
                    Spacer()
                  } //: HSTACK
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
            }
        }
        .onAppear(perform: {
          isAnimating = true
        })
        .preferredColorScheme(.light)
    }
}

struct Home_Previews: PreviewProvider {
    @State static var isOnboardingViewActive: Bool = true

    static var previews: some View {
        Home(isOnboardingViewActive: $isOnboardingViewActive)
    }
}
