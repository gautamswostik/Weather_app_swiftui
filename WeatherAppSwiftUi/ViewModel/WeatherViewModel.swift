//
//  WeatherViewModel.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 23/12/2022.
//

import Foundation


class WeatherViewModel : ObservableObject {
    
    @Published var userInput: String = ""
    @Published var errorMessage : String = ""
    @Published var shouldPresentAlert : Bool = false
    @Published var weatherData : WeatherData = WeatherData()
    @Published var astronomyData : WeatherData = WeatherData()
    @Published var foreCastData : WeatherData = WeatherData()
    @Published var loadingCurrentWeather: Bool = false
    @Published var loadingAstrology: Bool = false
    @Published var loadingForecast: Bool = false
    @Published var latitude: String = String()
    @Published var longitude: String = String()
    
    private let validateUserInput = UserInputValidation()
    private let weatherService = WeatherApiManager()
    private let locationService = CurrentUserLocation()
    
    init() {
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        self.loadingCurrentWeather = true
        locationService.requestLocationPermission {location in
            switch (location) {
            case .success(let locationData):
                DispatchQueue.main.async {
                    self.latitude = "\(locationData.coordinate.latitude)"
                    self.longitude = "\(locationData.coordinate.longitude)"
                    if(!"\(locationData.coordinate.latitude)".isEmpty){
                        self.fetchWeatherData(location: "\(locationData.coordinate.latitude),\(locationData.coordinate.longitude)")
                        self.fetchAstronomyData(location: "\(locationData.coordinate.latitude),\(locationData.coordinate.longitude)")
                        self.fetchForcastData(location: "\(locationData.coordinate.latitude),\(locationData.coordinate.longitude)")
                    }
                    
                }
            case .failure(let error):
                
                print("Error getting location: \(error)")
            }
        }
    }
    
    @discardableResult
    func validateInputFromUser() -> Bool {
        let result = validateUserInput.validateUserInput(location: userInput)
        if(!result.success){
            errorMessage = result.errorMessage ?? ""
            shouldPresentAlert = true
            return result.success
        }
        fetchWeatherData(location: userInput)
        return result.success
    }
    
    func fetchWeatherData(location: String) {
        self.loadingCurrentWeather = true
        weatherService.getWeatherData(location: location) { weatherDatas in
            switch (weatherDatas){
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.userInput = ""
                    self.weatherData = weatherData
                    self.loadingCurrentWeather = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingCurrentWeather = false
                    self.errorMessage = error.localizedDescription
                    self.shouldPresentAlert = true
                }
                
            }
        }
        
    }
    
    
    func fetchAstronomyData(location: String) {
        self.loadingAstrology = true
        weatherService.getAstronomyData(location: location) { astroDatas in
            switch (astroDatas){
            case .success(let astroData):
                DispatchQueue.main.async {
                    self.userInput = ""
                    self.astronomyData = astroData
                    self.loadingAstrology = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingAstrology = false
                    self.errorMessage = error.localizedDescription
                    self.shouldPresentAlert = true
                }
                
            }
        }
        
    }
    
    func fetchForcastData(location: String) {
        self.loadingForecast = true
        weatherService.getForcastData(location: location) { forecastDatas in
            switch (forecastDatas){
            case .success(let forcastData):
                DispatchQueue.main.async {
                    self.userInput = ""
                    self.foreCastData = forcastData
                    self.loadingForecast = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingForecast = false
                    self.errorMessage = error.localizedDescription
                    self.shouldPresentAlert = true
                }
                
            }
        }
        
    }
    
}
