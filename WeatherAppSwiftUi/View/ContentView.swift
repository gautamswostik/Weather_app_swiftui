//
//  ContentView.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 17/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body : some View {
        NavigationView {
            ZStack {
                Color.teal.ignoresSafeArea(.all)
                WeatherBody()
            }
            .navigationTitle(getGretting())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
