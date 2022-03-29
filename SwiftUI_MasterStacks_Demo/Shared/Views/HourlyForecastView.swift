//
//  HourlyForecastView.swift
//  SwiftUI_MasterStacks_Demo (iOS)
//
//  Created by Nadia Siddiqah on 7/12/21.
//

import SwiftUI

struct HourlyForecastView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                Text("Hourly Forecast".uppercased())
                Spacer()
            }
            .font(.system(size: 12, weight: .light, design: .default))
            .foregroundColor(.white)
            ForecastListView()
        }
        .padding()
        .background(Color.blue.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView()
    }
}
