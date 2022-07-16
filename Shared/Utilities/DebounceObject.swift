//
//  DebounceObject.swift
//  boissibook (iOS)
//
//  Created by Rémy Machavoine on 09/07/2022.
//

import Combine
import Foundation

public final class DebounceObject: ObservableObject {
    @Published var text: String = ""
    @Published var debouncedText: String = ""
    private var bag = Set<AnyCancellable>()

    public init(dueTime: TimeInterval = 0.9) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(dueTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                print("on passe dans le sink")
                self?.debouncedText = value
            })
            .store(in: &bag)
    }
}
