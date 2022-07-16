//
//  PdfView.swift
//  boissibook
//
//  Created by Swann HERRERA on 12/07/2022.
//

import SwiftUI
import PDFKit

struct PdfBookView: View {
    let data: Data
    
    var body: some View {
        PDFKitRepresentedView(data)
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let data: Data
    init(_ data: Data) {
        self.data = data
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: self.data)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {}
}
