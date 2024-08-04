//
//  CombinePublishedViewController.swift
//  MVVMPractice
//
//  Created by Aki on 2024/6/12.
//

import UIKit
import Combine

class CombinePublishedViewController: UIViewController {
    
    var viewModel = FormViewModel()
    let submitButton = UIButton()
    
    let buttonEvent = PassthroughSubject<Bool, Never>()
    
//    let eventPublisher = buttonEvent.eraseToAnyPublisher()
    
    let combineView = UIView()
    
    var bool = false
    
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
        submitButton.setTitle("Click", for: .normal)
        submitButton.addTarget(self, action: #selector(showCustomAlert), for: .touchUpInside)
        submitButton.backgroundColor = .lightGray
        //        // subscribe to a @Published property using the $ wrapped accessor
//        viewModel.$isSubmitAllowed
//            .receive(on: DispatchQueue.main)
//            .print()
//            .assign(to: \.isEnabled, on: submitButton)
        view.addSubview(combineView)
        combineView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(50)
            make.width.height.equalTo(50)
        }
        combineView.backgroundColor = .gray
        combineView.isHidden = false
            
        cancellable = buttonEvent.sink { bool in
            self.bool.toggle()
            self.combineView.isHidden = self.bool
        }
    }
    
    @objc
    private func showCustomAlert() {
        let customAlert = AlertBuilder()
            .setTitle("請至少選擇一個基本")
            .setContent("這個是message這個是message這個是message這個是message這個是message")
            .setButtonTitle("我知道了")
            .build()
        self.present(customAlert, animated: true)
        
        buttonEvent.send(bool)
    }
    
}

final class FormViewModel {
    @Published var isSubmitAllowed: Bool = true
}
