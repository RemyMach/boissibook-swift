//
// Created by Nospy on 06/07/2022.
//

import SwiftUI

struct UIKLabel: UIViewRepresentable{

    let attributedString: NSAttributedString
    let width: CGFloat

    init(_ attributedString: NSAttributedString, maxWidth: CGFloat) {
        self.attributedString = attributedString
        width = maxWidth
    }

    func makeUIView(context: Context) -> UILabel {
        let uiView = UILabel()
        uiView.lineBreakMode = .byWordWrapping
        uiView.numberOfLines = 0
        uiView.preferredMaxLayoutWidth = width
        return uiView;
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
