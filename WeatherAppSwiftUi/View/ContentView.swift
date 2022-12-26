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
                    CurrentWeatherInfo(
                        currentTemp: String(format: "%.0f", weatherViewModel.weatherData.current?.temp_c ?? 0.0),
                        currentLocation: weatherViewModel.weatherData.location?.name ?? "",
                        currentTime: getCurrentDateTime(date: weatherViewModel.weatherData.location?.localtime ?? ""),
                        sunRiseTime: weatherViewModel.astronomyData.astronomy?.astro?.sunrise ?? "",
                        sunSetTime: weatherViewModel.astronomyData.astronomy?.astro?.sunset ?? "",
                        loadingAstrology: weatherViewModel.loadingAstrology
                    )
                }
            }
        }
        
    }
}


struct CurrentWeatherInfo : View {
    var currentTemp : String
    var currentLocation : String
    var currentTime : String
    var sunRiseTime : String
    var sunSetTime : String
    var loadingAstrology : Bool
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("\(currentTemp)°c")
                    .font(.system(size: 80 , weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                Image(systemName: getCurrentDaySymbol())
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width:60 ,height:60)
                    .foregroundColor(getCurrentDaySymbol())
                
            }
            Text(currentLocation)
                .foregroundColor(.white)
                .font(.system(size: 30 , weight: .medium))
            
            Text(currentTime)
                .foregroundColor(.white)
                .font(.system(size: 20 , weight: .medium))
            
            AstroCardView(
                sunRiseTime: sunRiseTime,
                sunSetTime: sunSetTime,
                loadingAstrology: loadingAstrology
            )
        }.padding(.all , 20)
    }
}

struct AstroCardView : View {
    var sunRiseTime : String
    var sunSetTime : String
    var loadingAstrology : Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .shadow(radius: 8)
            HStack {
                if(loadingAstrology){
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }else {
                    AstroInfo(
                        title: "Sunrise",
                        time: sunRiseTime,
                        icon: "sunrise"
                    )
                    
                }
                
                Spacer()
                if(loadingAstrology){
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }else {
                    AstroInfo(
                        title: "Sunset",
                        time: sunSetTime,
                        icon: "sunset"
                    )
                }
            }.padding(.horizontal , 40)
                .padding(.vertical , 20)
        }
    }
}

struct AstroInfo : View {
    var title: String
    var time : String
    var icon : String
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20 , weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Text(time)
                .font(.system(size: 20 , weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: icon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width:60 ,height:60)
                .foregroundColor(.yellow)
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
