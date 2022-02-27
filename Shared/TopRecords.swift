//
//  TopRecords.swift
//  Tap to count
//
//  Created by Michal Jan Warecki on 27/02/2022.
//

import SwiftUI

struct TopRecords: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.duration, ascending: false)],
        animation: .default)
    private var records: FetchedResults<Record>
    private let numberOfRecords = 5
    
    var body: some View {
        List {
            Section("Beste") {
                ForEach(records[..<((records.indices.upperBound < numberOfRecords) ? records.indices.upperBound : numberOfRecords) ]) { record in
                    SingleRecordView(model: record)
                }
            }
        }
    }
}

public struct SingleRecordView: View {
    public let model: Record
    
    public var body: some View {
        HStack {
            Text("\(model.duration)")
            Spacer()
            Text(model.timestamp!, formatter: itemFormatter)
        }
    }
}

struct TopRecords_Previews: PreviewProvider {
    static var previews: some View {
        TopRecords().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
