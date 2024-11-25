//
//  ViewController.swift
//  BlueHunter
//
//  Created by Arkadiy Schneider on 26.11.2024.
//

import UIKit

class ViewController: UIViewController {
    private var bluetoothManager: BluetoothManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager = BluetoothManager()
        
    }

}
