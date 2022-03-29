//
//  ForecastReading.swift
//  SwiftUI_MasterStacks_Demo (iOS)
//
//  Created by Nadia Siddiqah on 7/12/21.
//

import Foundation

struct ForecastReading {
    let time: String
    let symbol: String
    let temp: Double
}

extension ForecastReading {
    
    static let dummyWeatherData = [
        ForecastReading(time: "Now", symbol: "sun.max.fill", temp: 109),
        ForecastReading(time: "6 AM", symbol: "sun.max.fill", temp: 107),
        ForecastReading(time: "7 AM", symbol: "sun.max.fill", temp: 106),
        ForecastReading(time: "8 AM", symbol: "sun.max.fill", temp: 105),
        ForecastReading(time: "8:33 AM", symbol: "cloud.sun.fill", temp: 106),
        ForecastReading(time: "9 AM", symbol: "cloud.sun.fill", temp: 107),
        ForecastReading(time: "10 AM", symbol: "cloud.sun.fill", temp: 90)
    ]
}
