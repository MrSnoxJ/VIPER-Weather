//
//  MainInteractor.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import Foundation



class MainInteractor: MainInteractorProtocol {
   
    
    private var apiKey = "2e806c6aeb44e18ccaef341a22c7474c"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let cacheManager = CacheManager()
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    private func convertToFahrenheit(from celsius: Double) -> Double {
            return (celsius * 9/5) + 32
        }
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data:")
                print(jsonString)
            } else {
                print("Failed to decode JSON data")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                var weatherData = try decoder.decode(WeatherData.self, from: data)
                let temperatureCelsius = weatherData.main.temp - 273.15
                self.saveWeatherData(weatherData, for: city)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
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
