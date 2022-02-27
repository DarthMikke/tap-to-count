//
//  StopwatchView.swift
//  Tap to count
//
//  Created by Michal Jan Warecki on 26/02/2022.
//

import Foundation
import SwiftUI

struct StopwatchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var model = Stopwatch()
    
    let timeThreshold = 0.2
    
    var body: some View {
        VStack {
            Text(self.model.elapsedString).font(.system(size: 42.0))
            ZStack {
                Circle()
                    .frame(width: 100.0, height: 100.0)
                    .foregroundColor(Color.gray)
                Image(systemName: self.model.isCounting ? "pause.fill" : "play.fill")
                    .scaleEffect(3.0)
                    .frame(width: 100.0, height: 100.0)
            }
                .padding(.bottom, 50.0)
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged { _ in
                            if !self.model.isCounting {
                                self.model.start()
                            }
                        }
                        .onEnded { _ in
                            if self.model.isCounting {
                                if self.model.elapsed > timeThreshold {
                                    self.model.stop()
                                    self.saveRecord(duration: self.model.elapsed)
                                }
                            }
                            print("Finished!")
                        }
                )
        }
    }
    
    func saveRecord(duration: Double) {
        let newRecord = Record(context: viewContext)
        newRecord.timestamp = Date()
        newRecord.duration = duration
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

