//
//  NavigationService.swift
//  Weather
//
//  Created by Yerassyl Tynymbay on 05.03.2024
//  
//


import SwiftUI

public class NavigationService:  NavigationServiceType  {
    func pushView(_ view: Views) {
        items.append(view)
    }
    public let id = UUID()
    
    public static func == (lhs: NavigationService, rhs: NavigationService) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var modalView: Views?
    @Published var items: [Views] = []
    @Published var alert: CustomAlert?
    
    
    
}


enum Views: Equatable, Hashable {
    
    static func == (lhs: Views, rhs: Views) -> Bool {
        lhs.stringKey == rhs.stringKey
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.stringKey)
    }
   
    
    case main
    case detailWeather
    var stringKey: String {
        switch self {
        case .main:
            return "main"
        case .detailWeather:
            return "detailView"
        }
    }
}


class StubNavigation: NavigationServiceType, ObservableObject, Equatable  {
    func pushView(_ view: Views) {
        items.append(view)
    }
    
    
    
    @Published var modalView: Views?
    @Published var alert: CustomAlert?
    
    public let id = UUID()
    
    public static func == (lhs: StubNavigation, rhs: StubNavigation) -> Bool {
        lhs.id == rhs.id
    }
    
    fileprivate init() {}
    
    static var stub: any NavigationServiceType { NavigationService() }
    
    @Published var items: [Views] = []
}

enum CustomAlert: Equatable, Hashable {
    static func == (lhs: CustomAlert, rhs: CustomAlert) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .defaultAlert:
            hasher.combine("defaultAlert")
        }
    }
    
    case defaultAlert(yesAction: (()->Void)?, noAction: (()->Void)?)
}
