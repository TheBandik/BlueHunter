//
//  ViewController.swift
//  BlueHunter
//
//  Created by Arkadiy Schneider on 26.11.2024.
//

import UIKit

class ViewController: UIViewController {
    private var bluetoothManager: BluetoothManager!
    
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupStackView()
        
        bluetoothManager = BluetoothManager()
        
        bluetoothManager.onNewPeripheralDiscovered = { [weak self] peripheral, rssi in
            self?.addTextField(text: "Discovered: \(peripheral.name ?? "Unknown device") at \(rssi) dBm")
        }
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical // Вертикальное расположение
        stackView.spacing = 8 // Отступы между элементами
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Фиксируем ширину
        ])
    }
    
    private func addTextField(text: String) {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false // Отключаем редактирование
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Устанавливаем высоту текстового поля
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Добавляем в StackView
        stackView.addArrangedSubview(textView)
    }
}
