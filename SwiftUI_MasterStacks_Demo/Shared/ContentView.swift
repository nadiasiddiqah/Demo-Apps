//
//  ContentView.swift
//  Shared
//
//  Created by Nadia Siddiqah on 7/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List {
            HourlyForecastView()
                .listRowInsets(EdgeInsets())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
