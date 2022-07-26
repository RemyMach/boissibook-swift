//
//  ToastModifier.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 26/07/2022.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    
    @Binding var isShowing: Bool
    let duration: TimeInterval
    let status: String
   
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                if status == "Error" {
                    ErrorToastView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isShowing = false
                                }
                            }
                        }
                }else if status == "Network_Problem" {
                    NoNetworkToastView()
                }
            }
        }
    }
}
    
extension View {
    func toast(isShowing: Binding<Bool>, status:  String, duration: TimeInterval = 3) -> some View {
        modifier(ToastModifier(isShowing: isShowing, duration: duration, status: status))
    }
}

