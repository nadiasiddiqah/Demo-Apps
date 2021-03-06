//
//  ContentView.swift
//  Shared
//
//  Created by Nadia Siddiqah on 7/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries: [GetAllCountriesQuery.Data.Country] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List(countries, id: \.code) { country in
                    NavigationLink(
                        destination: CountryDetailView(country: country),
                        label: {
                            HStack {
                                Text(country.emoji)
                                Text(country.name)
                            }
                        })
                }
                .listStyle(PlainListStyle())
            }
            .onAppear(perform: {
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()) { result in
                    switch result {
                    case .success(let graphQLResult):
                        // Always assign state on main queue
                        if let countries = graphQLResult.data?.countries {
                            DispatchQueue.main.async {
                                self.countries = countries
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
            .navigationTitle("Countries")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
