//
//  Debouncer.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation

class Debouncer {
    private var workItem: DispatchWorkItem?
    private let delay: TimeInterval

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func call(_ action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem!)
    }

    func cancel() {
        workItem?.cancel()
    }

    func forceCall() {
        workItem?.perform()
        workItem = nil
    }
}
