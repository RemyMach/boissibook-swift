//
//  NeNetworkToastView.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 26/07/2022.
//

import SwiftUI

struct NoNetworkToastView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "network")
                Text("Vous n'avez pas de connection internet")
                    .font(.footnote)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
        }
        .padding()
    }
}

struct NoNetworkToastView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkToastView()
    }
}
