//
//  ForecastView.swift
//  SwiftUI_MasterStacks_Demo (iOS)
//
//  Created by Nadia Siddiqah on 7/12/21.
//

import SwiftUI

struct ForecastView: View {
    
    let forecast: ForecastReading
    
    var body: some View {
        VStack(spacing: 12) {
            Text(forecast.time)
                .font(.system(size: 12, weight: .bold, design: .default))
            Image(systemName: forecast.symbol)
                .renderingMode(.original)
            Text(format(temp: forecast.temp))
                .font(.system(size: 16, weight: .medium, design: .default))
        }
        .foregroundColor(.white)
    }
    
    private func format(temp: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .temperatureWithoutUnit
        
        let tempInDegrees = Measurement(value: temp, unit: UnitTemperature.celsius)
        return formatter.string(from: tempInDegrees)
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(forecast: ForecastReading.dummyWeatherData.first!)
            .previewLayout((.sizeThatFits))
            .padding()
            .background(Color.black)
    }
}
