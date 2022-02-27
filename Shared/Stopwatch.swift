//
//  Stopwatch.swift
//  Tap to count
//
//  Created by Michal Jan Warecki on 26/02/2022.
//

import Foundation

class Stopwatch: ObservableObject {
    @Published var isCounting = false
    var startFrom = Date()
    var stoppedAt = Date()
    
    public var elapsed: Double {get {
        self.isCounting
            ? (Date().timeIntervalSince1970 - self.startFrom.timeIntervalSince1970)
            : (self.stoppedAt.timeIntervalSince1970 - self.startFrom.timeIntervalSince1970)
    } }
    
    public var elapsedString: String { get {
        
        // Following from:
        // https://crunchybagel.com/formatting-a-duration-with-nsdatecomponentsformatter/
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]

        return formatter.string(from: self.elapsed)!

    } }
    
    func start() -> Void {
        if self.isCounting { return }
        
        self.startFrom = Date()
        self.isCounting = true
        self.update()
    }
    
    func update() -> Void {
        self.objectWillChange.send()
        if self.isCounting {
            DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .seconds(1)), execute: { self.update() })
        }
    }
    
    func stop() {
        if self.isCounting {
            self.isCounting = false
            self.stoppedAt = Date()
        }
    }
}
