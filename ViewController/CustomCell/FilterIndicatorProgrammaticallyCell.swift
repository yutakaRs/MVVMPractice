//
//  FilterIndicatorProgrammaticallyCell.swift
//  EmilyFixedStock
//
//  Created by Aki on 2024/6/25.
//  Copyright © 2024 CMoney. All rights reserved.
//

import Foundation
import UIKit


class FilterIndicatorProgrammaticallyCell : UITableViewCell {
    
    static let identifier = "FilterIndicatorProgrammaticallyCell"
    
    /*private*/ lazy var nameLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var tipButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "detail"), for: .normal)
        return button
    }()
    
    private lazy var limitImage : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "suo")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var filterSwitchButton : UISwitch = {
       let switchButton = UISwitch()
        
        return switchButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(tipButton)
        addSubview(limitImage)
        addSubview(filterSwitchButton)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
        }
        
        tipButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameLabel.snp.trailing).offset(10)
        }
        
        limitImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(filterSwitchButton.snp.leading).offset(-16)
            $0.width.equalTo(21.5)
            $0.height.equalTo(27.9)
        }
        
        filterSwitchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(21)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(options: [MonitorObjectType], currentOption: MonitorObjectType) {
        nameLabel.text = "NameLabel"
//        monitorOptions = options
//        selectedOption = currentOption
//        setupAllOptionButtons(options: options)
        
//        tipButton.isHidden == currentOption.mainWord
    }
    
}
