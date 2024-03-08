//
//  MainInteractor.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import Foundation
class MainInteractor: MainInteractorProtocol {
   
    private let weatherService: WeatherService
    private let cacheManager = CacheServiceType()
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
   
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
            Task {
                do {
                    let weatherData = try await weatherService.fetchWeather(for: city)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    private func saveWeatherData(_ weartherData : WeatherData, for city : String) {
        cacheManager.saveWeatherData(weartherData, for: city)
    }
    private func loadWeatherData (for city : String) -> WeatherData? {
        return cacheManager.loadWeatherData(for: city)
    }
}
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case invalidCity
}


// MARK: Private
extension MainInteractor {
    
}
