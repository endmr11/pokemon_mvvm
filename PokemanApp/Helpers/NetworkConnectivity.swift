//
//  NetworkConnectivity.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation
import Alamofire

final class AppNetworkConnectivity {
    static var isInternetAvailable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
