//
//  CustomAlertViewController.swift
//  EmilyFixedStock
//
//  Created by Aki on 2024/6/19.
//  Copyright © 2024 CMoney. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertViewController: UIViewController {
    // MARK: Lifecycle

    init(title: String, message: String, buttonTitle: String) {
        alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    var didTapConfirmButton: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .black.withAlphaComponent(0.25)
        confirmButton.addTarget(self, action: #selector(didDismiss), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.alpha = 0
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.alpha = 1
        }, completion: nil)
    }

    // MARK: Private

    private var alertTitle: String

    private var message: String

    private var buttonTitle: String
    private var alertContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var alertStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, messageView, confirmButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()

    let titleView = UIView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = alertTitle
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let messageView = UIView()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = message
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var dividendLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()

    @objc
    private func didDismiss() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }.startAnimation()
    }

    private func setupUI() {
        let backgroundButton = UIButton()
        backgroundButton.backgroundColor = .black.withAlphaComponent(0.25)
        backgroundButton.addTarget(self, action: #selector(didDismiss), for: .touchUpInside)
        view.addSubview(backgroundButton)
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(alertContainer)
        alertContainer.addSubview(alertStackView)
        alertContainer.addSubview(dividendLine)
        
        alertStackView.setCustomSpacing(8, after: messageView)

        alertContainer.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(270)
        }

        alertStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
        titleView.isHidden = alertTitle.isEmpty
        
        messageView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview().inset(16)
        }
        messageView.isHidden = message.isEmpty

        dividendLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(confirmButton.snp.top)
            $0.height.equalTo(0.5)
        }

        confirmButton.snp.makeConstraints {
            $0.height.equalTo(43)
        }
    }
}

public class AlertBuilder {
    // MARK: Internal

    func setTitle(_ title: String) -> AlertBuilder {
        self.title = title
        return self
    }

    func setContent(_ message: String) -> AlertBuilder {
        self.message = message
        return self
    }

    func setButtonTitle(_ buttonTitle: String) -> AlertBuilder {
        self.buttonTitle = buttonTitle
        return self
    }

    func build() -> CustomAlertViewController {
        return CustomAlertViewController(title: title,
                                         message: message,
                                         buttonTitle: buttonTitle)
    }

    // MARK: Private

    private var title: String = ""

    private var message: String = ""

    private var buttonTitle: String = ""
}
