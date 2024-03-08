//
//  WeatherService.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 07.03.2024.
//

import Foundation
protocol WeatherService {
    func fetchWeather(for city: String) async throws -> WeatherData
}

class DefaultWeatherService: WeatherService {
    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    init(apiKey: String) {
        self.apiKey = apiKey
    }
    func fetchWeather(for city: String) async throws -> WeatherData {
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        do {
            let data = try await fetchData(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            return weatherData
        } catch {
            throw error
        }
    }
    private func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
