//
//  Utils.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 23/12/2022.
//

import Foundation
import SwiftUI


func getGretting() ->String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    switch true{
    case (hour < 12):
        return "Good morning"
    case (hour < 17):
        return "Good afternoon"
    default:
        return "Good evening"
    }
}

func getCurrentDaySymbol() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    switch true{
    case (hour < 12):
        return "sun.min"
    case (hour < 17):
        return "sun.max"
    default:
        return "moon.fill"
    }
}


func getCurrentDaySymbol() -> Color {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    switch true{
    case (hour < 17):
        return .yellow
    default:
        return .white
    }
}


func getCurrentDateTime(date : String) -> String {
    
    let inputFormatter = DateFormatter()
    // should be exact format of date to convert
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    if let date = inputFormatter.date(from: date) {
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE, h:mm a"
        let outputString = outputFormatter.string(from: date)
        print(outputString)
        return outputString
    }
    return ""
}

func getCurrentDateTime() -> String {
    let date = Date()
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
     let currentdate = inputFormatter.string(from: date)
    return currentdate
}

func getCurrentDateInTimeFormat(date : String) -> String {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    if let date = inputFormatter.date(from: date) {
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h:mm a"
        let outputString = outputFormatter.string(from: date)
        print(outputString)
        return outputString
    }
    return ""
}
