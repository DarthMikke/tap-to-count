//
//  ContentView.swift
//  Shared
//
//  Created by Michal Jan Warecki on 26/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            VStack {
                TopRecords()
                Spacer()
                StopwatchView()
            }
                .tabItem{ Label("Tidtakar", systemImage: "clock.arrow.circlepath") }
            RecordsList()
                .tabItem { Label("Liste", systemImage: "list.dash") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
