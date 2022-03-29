//
//  ForecastListView.swift
//  SwiftUI_MasterStacks_Demo (iOS)
//
//  Created by Nadia Siddiqah on 7/12/21.
//

import SwiftUI

struct ForecastListView: View {
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(ForecastReading.dummyWeatherData,
                        id: \.time) { forecast in
                    ForecastView(forecast: forecast)
                }
            }
        }
        
    }
}

struct ForecastListView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastListView()
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
