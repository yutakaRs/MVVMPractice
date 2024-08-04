//
//  FilterMonitorObjectProgrammaticallyCell.swift
//  EmilyFixedStock
//
//  Created by Aki on 2024/6/25.
//  Copyright © 2024 CMoney. All rights reserved.
//

import Foundation
import UIKit

class FilterMonitorObjectProgrammaticallyCell : UITableViewCell {
    
    static let identifier = "FilterMonitorObjectProgrammaticallyCell"
    
    private var containerView : UIView = {
       let view = UIView()
        return view
    }()
    
    var monitorObjectTitleLabel: UILabel = {
       let monitorLabel = UILabel()
        monitorLabel.font = .systemFont(ofSize: 20)
        monitorLabel.text = "HELLO World"
        monitorLabel.textColor = .white
        monitorLabel.numberOfLines = 1
        return monitorLabel
    }()
    
    private var dropdownSelectButton: UIButton = {
       let dropButton = UIButton()
        dropButton.backgroundColor = .systemPink
        return dropButton
    }()
    
    private let dropdownImage : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteDownTriangle")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var onClickDropdownButton: ((Bool) -> (UIView?))?
    var takeLastSelectItem: ((MonitorObjectType) -> ())?
    
    private var monitorOptions: [MonitorObjectType] = []
    private var selectedOption: MonitorObjectType?
    private var dropdownSelectButtons: [UIButton] = []
    private var dropdownSelectStackView: UIStackView!
    private var dropdownSelectView: UIView!
    private var isDropdownSelectViewOpened: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(dropdownSelectButton)
        containerView.addSubview(monitorObjectTitleLabel)
        containerView.addSubview(dropdownImage)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dropdownSelectButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(11)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        monitorObjectTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(dropdownSelectButton)
            $0.leading.equalTo(dropdownSelectButton.snp.leading).offset(17)
            $0.trailing.lessThanOrEqualTo(dropdownImage.snp.leading)
        }
        
        dropdownImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-17)
            $0.width.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        if !dropdownSelectButtons.isEmpty {
            dropdownSelectButtons = []
        }
        if dropdownSelectStackView != nil, !dropdownSelectStackView.subviews.isEmpty {
            dropdownSelectStackView.removeAllArrangedSubviews()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(options: [MonitorObjectType], currentOption: MonitorObjectType) {
        monitorObjectTitleLabel.attributedText = setupDropdownOptionTextAttribute(option: currentOption)
        monitorOptions = options
        selectedOption = currentOption
        setupAllOptionButtons(options: options)
    }
    
    private func clickToChangeDropdownSelect(_ sender: UIButton) {
        isDropdownSelectViewOpened = !isDropdownSelectViewOpened
        if let parentView = onClickDropdownButton?(isDropdownSelectViewOpened) {
            let viewPoint = sender.convert(sender.bounds, to: parentView)
            let rect = CGRect(x: viewPoint.minX, y: viewPoint.maxY, width: sender.bounds.width, height: 0)
            addSelectView(rect: rect, parentView: parentView, isDropOpen: isDropdownSelectViewOpened)
        }
    }
    
}

private extension FilterMonitorObjectProgrammaticallyCell {
    
    func setupAllOptionButtons(options: [MonitorObjectType]) {
        dropdownSelectButtons = options.map {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: dropdownSelectButton.bounds.width, height: dropdownSelectButton.bounds.height))
            button.setAttributedTitle(setupDropdownOptionTextAttribute(option: $0, color: .lightGray), for: .normal)
            button.tag = $0.rawValue
            button.addTarget(self, action: #selector(changeSelectItem(sender:)), for: .touchUpInside)
            return button
        }
    }
    
    func setupDropdownOptionTextAttribute(option: MonitorObjectType, color: UIColor = .white) -> NSAttributedString {
        let selectedText = option.mainWord + option.subWord
        let attributedString = NSMutableAttributedString(
            string: selectedText,
            attributes: [.font: UIFont.systemFont(ofSize: 20),
                         .foregroundColor: color,
                         .kern: 0.0]
        )
        attributedString.addAttribute(
            .foregroundColor,
            value: color,
            range: NSRange(location: 0, length: selectedText.count - 1)
        )
        if !option.subWord.isEmpty {
            attributedString.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: 13),
                range: NSRange(location: option.mainWord.count, length: option.subWord.count))
        }
        return attributedString
    }
    
    @objc func changeSelectItem(sender: UIButton) {
        if let option = monitorOptions.first(where: { $0.rawValue == sender.tag }) {
            monitorObjectTitleLabel.attributedText = setupDropdownOptionTextAttribute(option: option)
            selectedOption = option
            takeLastSelectItem?(option)
            clickToChangeDropdownSelect(sender)
        }
    }
    
    func setupDropSelectStackView() {
        dropdownSelectStackView = UIStackView()
        dropdownSelectStackView.axis = .vertical
        dropdownSelectStackView.distribution = .fill
        dropdownSelectStackView.alignment = .fill
        let selectButtons = dropdownSelectButtons.filter {
            $0.tag != selectedOption?.rawValue
        }
        for i in 0..<selectButtons.count {
            let view = UIView()
            view.addSubview(selectButtons[i])
            selectButtons[i].snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
            if i != selectButtons.count - 1 {
                let lineView = UIView()
                lineView.backgroundColor = .blue
                view.addSubview(lineView)
                lineView.snp.makeConstraints { (make) in
                    make.top.equalTo(selectButtons[i].snp.bottom)
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.equalToSuperview().offset(-20)
                    make.height.equalTo(1)
                }
            }
            dropdownSelectStackView.addArrangedSubview(view)
        }
    }
    
    func addSelectView(rect: CGRect, parentView: UIView, isDropOpen: Bool) {
        guard isDropdownSelectViewOpened else {
            dropdownSelectView.removeFromSuperview()
            return
        }
        setupDropSelectStackView()
        
        dropdownSelectView = UIView()
        dropdownSelectView.backgroundColor = .lightGray
        dropdownSelectView.layer.cornerRadius = 8
        dropdownSelectView.addSubview(dropdownSelectStackView)
        
        dropdownSelectStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        parentView.addSubview(dropdownSelectView)
        
        dropdownSelectView.snp.makeConstraints { (make) in
            make.top.equalTo(rect.maxY)
            make.leading.equalTo(rect.minX)
            make.width.equalTo(rect.width)
        }
    }
}
