//
// Created by Nospy on 06/07/2022.
//

import Foundation

// Convert string to HTML
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        let upgradedString = "<html><head><style>body { font-family: -apple-system; font-size: 16px; }</style></head><body>"
            + self
            + "</body></html>";
        guard let data = upgradedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            )
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
