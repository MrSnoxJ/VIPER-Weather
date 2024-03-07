//
//  MainViewState.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//

import SwiftUI

final class MainViewState: ObservableObject, MainViewStateProtocol {    
    private let id = UUID()
    private var presenter: MainPresenterProtocol?
    
    func set(with presener: MainPresenterProtocol) {
        self.presenter = presener
    }
}
