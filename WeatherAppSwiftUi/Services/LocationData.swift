//
//  LocationData.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 21/12/2022.
//

import Foundation

enum ApiError : Error {
    case badResponse(statusCode : Int)
}

class WeatherApiManager {
    static let scope = WeatherApiManager()
    
    func getWeatherData(location: String , completionHandler: @escaping (Result<WeatherData , Error> ) -> Void) {
        guard let baseURL = URL(string: ApiUrls.currentUrl) else {return}

        /**
    
         If resolvingAgainstBaseURL is true, the URL components are resolved against the base URL. This means that if any of the URL components (such as the scheme, host, or path) are not specified in the URLComponents object, they will be inherited from the base URL.
         **/
        guard var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {return}
        
        urlComponent.queryItems = [
            URLQueryItem(name: ApiKeys.key, value: ApiConstants.apiKey),
            URLQueryItem(name: ApiKeys.location , value: location)
        ]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: urlComponent.url!)) {(data , response , error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            print(response.statusCode)
            
            if((200...299).contains(response.statusCode)){
                guard let weatherData = data else {return}
                
                let decoder = JSONDecoder()
                
                do {
                    let weatherResponse = try decoder.decode(WeatherData.self, from: weatherData)
                    completionHandler(.success(weatherResponse))
                } catch {
                    completionHandler(.failure(error))
                }

            }else{
                completionHandler(.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }
            
        }
        
        task.resume()
    }
    
    
    func getAstronomyData(location: String , completionHandler: @escaping (Result<WeatherData , Error> ) -> Void) {
        guard let baseURL = URL(string: ApiUrls.astronomyUrl) else {return}
        guard var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {return}
        
        urlComponent.queryItems = [
            URLQueryItem(name: ApiKeys.key, value: ApiConstants.apiKey),
            URLQueryItem(name: ApiKeys.location , value: location),
            URLQueryItem(name: ApiKeys.dateTime , value: location)
        ]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: urlComponent.url!)) {(data , response , error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            print(response.statusCode)
            
            if((200...299).contains(response.statusCode)){
                guard let weatherData = data else {return}
                
                let decoder = JSONDecoder()
                
                do {
                    let weatherResponse = try decoder.decode(WeatherData.self, from: weatherData)
                    completionHandler(.success(weatherResponse))
                } catch {
                    completionHandler(.failure(error))
                }

            }else{
                completionHandler(.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }
            
        }
        
        task.resume()
    }
    
    func getForcastData(location: String , completionHandler: @escaping (Result<WeatherData , Error> ) -> Void) {
        guard let baseURL = URL(string: ApiUrls.forecastUrl) else {return}
        guard var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {return}
        
        urlComponent.queryItems = [
            URLQueryItem(name: ApiKeys.key, value: ApiConstants.apiKey),
            URLQueryItem(name: ApiKeys.location , value: location),
            URLQueryItem(name: ApiKeys.days , value: "1"),
            URLQueryItem(name: ApiKeys.aqi , value: "no"),
            URLQueryItem(name: ApiKeys.alerts , value: "no")
        ]
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: urlComponent.url!)) {(data , response , error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            print(response.statusCode)
            
            if((200...299).contains(response.statusCode)){
                guard let weatherData = data else {return}
                
                let decoder = JSONDecoder()
                
                do {
                    let weatherResponse = try decoder.decode(WeatherData.self, from: weatherData)
                    completionHandler(.success(weatherResponse))
                } catch {
                    completionHandler(.failure(error))
                }

            }else{
                completionHandler(.failure(ApiError.badResponse(statusCode: response.statusCode)))
            }
            
        }
        
        task.resume()
    }
}
