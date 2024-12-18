//
//  BluetoothManager.swift
//  BlueHunter
//
//  Created by Arkadiy Schneider on 26.11.2024.
//

import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    private var centralManager: CBCentralManager!
    private(set) var discoveredPeripherals: [CBPeripheral] = []
    
    var onNewPeripheralDiscovered: ((CBPeripheral, NSNumber) -> Void)?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is powered on. Starting scan...")
            centralManager.scanForPeripherals(
                withServices: nil,
                options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]
            )
        case .poweredOff:
            print("Bluetooth is powered off.")
        case .unsupported:
            print("Bluetooth is not supported on this device.")
        case .unauthorized:
            print("Bluetooth usage is not authorized.")
        default:
            print("Unknown Bluetooth state: \(central.state)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //        print("Discovered: \(peripheral.name ?? "Unknown device") at \(RSSI)dBm")
        if peripheral.name != nil {
            discoveredPeripherals.append(peripheral)
            onNewPeripheralDiscovered?(peripheral, RSSI)
            
        }
    }
}
