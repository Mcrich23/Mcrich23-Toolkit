//
//  NetworkMonitor.swift
//  JokesRUs
//
//  Created by user192301 on 3/23/21.
//

import Foundation
import Network

/**
 Monitoring the network connection
 - returns: connectionType
 - warning: You must call startMonitoring in order for NetworkMonitor to start working.
 
 # Example #
 ```
 if NetworkMonitor.shared.connectionType != .unknown {
    print("Connected to the internet)
 }
 ```
 */
public final class NetworkMonitor {
    public static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType? = .unknown
    
    public enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    public init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            
            self?.getConnectionType(path)
        }
    }
    
    public func startMonitoring(onUpdate: @escaping (_ isConnected: Bool) -> Void) {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
            if path.status != .unsatisfied {
                onUpdate(true)
            } else {
                onUpdate(false)
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
