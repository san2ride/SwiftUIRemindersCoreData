//
//  Delay.swift
//  RemindersSwiftUICoreData
//
//  Created by Cause I'm Electric on 3/14/24.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        // creating instance of workItem
        workItem = DispatchWorkItem(block: {
            work()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    func cancel() {
        workItem?.cancel()
    }
}
