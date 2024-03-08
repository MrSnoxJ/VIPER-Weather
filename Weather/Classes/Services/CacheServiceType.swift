//
//  cacheService.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 07.03.2024.
//

import Foundation

class CacheServiceType{
    private let cacheDirectory: URL
    
    init() {
        
        if let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            cacheDirectory = cacheURL
        } else {
            
            cacheDirectory = FileManager.default.temporaryDirectory
        }
    }
    
    func saveWeatherData(_ weatherData: WeatherData, for city: String) {
        
        let fileURL = cacheDirectory.appendingPathComponent("\(city).json")
        do {
            let jsonData = try JSONEncoder().encode(weatherData)
            try jsonData.write(to: fileURL)
        } catch {
            print("Error saving weather data:", error)
        }
    }
    
    func loadWeatherData(for city: String) -> WeatherData? {
        
        let fileURL = cacheDirectory.appendingPathComponent("\(city).json")
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: jsonData)
            return weatherData
        } catch {
            print("Error loading weather data:", error)
            return nil
        }
    }
}
