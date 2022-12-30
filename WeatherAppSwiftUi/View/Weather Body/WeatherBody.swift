//
//  WeatherBody.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 24/12/2022.
//

import SwiftUI

struct WeatherBody : View {
    //@ObservedObject var weatherViewModel = WeatherViewModel()
    @StateObject var weatherViewModel = WeatherViewModel()
    var body : some View {
        if(weatherViewModel.loadingCurrentWeather) {
            ZStack {
                Color.white.ignoresSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }else {
            ScrollView {
                VStack {
                    //ADD SEARCH FIELD
//                    TextField
                    CurrentWeatherInfo(
                        currentTemp: String(format: "%.0f", weatherViewModel.weatherData.current?.temp_c ?? 0.0),
                        currentLocation: weatherViewModel.weatherData.location?.name ?? "",
                        currentTime: getCurrentDateTime(date: weatherViewModel.weatherData.location?.localtime ?? "")
                    )
                    
                    AstroCardView(
                        sunRiseTime: weatherViewModel.astronomyData.astronomy?.astro?.sunrise ?? "",
                        sunSetTime: weatherViewModel.astronomyData.astronomy?.astro?.sunset ?? "",
                        loadingAstrology: weatherViewModel.loadingAstrology
                    )
                    
                    WindAndHumidityInfo(
                        windInfo: "\(weatherViewModel.weatherData.current?.wind_kph ?? 0.0)",
                        humidityInfo: "\(weatherViewModel.weatherData.current?.humidity ?? 0)",
                        pressure: "\(weatherViewModel.weatherData.current?.pressure_mb ?? 0.0)"
                    )
                    
                    // ADD SEE MORE FUNCTIONALITY (SHOW ONLY 5 at first and show all at expand)
                    ForecastData(hourData: weatherViewModel.foreCastData.forecast?.forecastday?.first?.hour ?? [])
                    
                }.padding(.horizontal , 20)
            }
        }
        
    }
}
