//
//  ViewController.swift
//  APIRequest
//
//  Created by Nadia Siddiqah on 1/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.sunrise-sunset.org/json?date=2020-01-01&lat=-74.0060&lng=40.7128&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        
        // request data
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            // check data exists
            guard let data = data, error == nil else {
                print("Something went wrong.")
                return
            }
            
            // have data, convert to Response struct
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else { return }
            
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
            
        }.resume()
    }
    
}

struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

//{
//  "results": {
//    "sunrise": "1970-01-01T00:00:01+00:00",
//    "sunset": "1970-01-01T00:00:01+00:00",
//    "solar_noon": "2020-01-01T09:20:25+00:00",
//    "day_length": 0,
//    "civil_twilight_begin": "1970-01-01T00:00:01+00:00",
//    "civil_twilight_end": "1970-01-01T00:00:01+00:00",
//    "nautical_twilight_begin": "1970-01-01T00:00:01+00:00",
//    "nautical_twilight_end": "1970-01-01T00:00:01+00:00",
//    "astronomical_twilight_begin": "1970-01-01T00:00:01+00:00",
//    "astronomical_twilight_end": "1970-01-01T00:00:01+00:00"
//  },
//  "status": "OK"
//}
