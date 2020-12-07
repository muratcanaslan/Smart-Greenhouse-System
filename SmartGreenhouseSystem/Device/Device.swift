//
//  Device.swift
//  SmartGreenhouseSystem
//
//  Created by Murat Can on 21.11.2020.
//

import Foundation
import Particle_SDK

class Device: NSObject {
    var device: ParticleDevice?
    
    static let sharedInstance = Device()
    
    private override init() {
        super.init()
    }
    
    func setDevice(device: ParticleDevice) {
        self.device = device
    }
    
    func dropDevice() {
        self.device = nil
    }
}
