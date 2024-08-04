//
//  FilterIndicatorProgrammaticallyViewController.swift
//  EmilyFixedStock
//
//  Created by Aki on 2024/6/25.
//  Copyright © 2024 CMoney. All rights reserved.
//

import UIKit
import Combine
import SnapKit

protocol FilterIndicatorIsChangedDelegate: AnyObject {
    func getFilterIsChange(isChange: Bool)
}

class FilterIndicatorProgrammaticallyViewController: UIViewController {
    
    private var cancellable : AnyCancellable?
    
    weak var isChangeDelegate: FilterIndicatorIsChangedDelegate?

//    var filterIndicatorViewModel: FilterIndicatorViewModel?
    
//    private var dataSource: UITableViewDiffableDataSource<Int, FilterSettingSection>?
    
    private lazy var stackView : UIStackView = {
       let sv = UIStackView()
        sv.addArrangedSubviews([tableView,noticeView])
        sv.axis = .vertical
        sv.spacing = 0
        return sv
    }()
    
    private lazy var tableView : UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        return tableView
    }()
    
    private var noticeView : UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var confirmButton : UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "確定"
        button.target = self
        return button
    }()
    
    private lazy var cancelButton : UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = "取消"
        button.target = self
        return button
    }()
    
    let mockHeader = ["觀察對象","基本條件","進階條件"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNoticeView()
        setupNavigationBar()
    }
    
    private func setupUI(){
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        tableView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(noticeView.snp.top)
//        }
//        tableView.tableFooterView = UIView(frame: .zero)
//        
//        noticeView.snp.makeConstraints { make in
//            make.leading.bottom.trailing.equalToSuperview()
//            make.height.equalTo(80)
//        }
        
        // Monitor cell
        tableView.register(FilterMonitorObjectProgrammaticallyCell.self, forCellReuseIdentifier: FilterMonitorObjectProgrammaticallyCell.identifier)
        // Indicator cell
        tableView.register(FilterIndicatorProgrammaticallyCell.self, forCellReuseIdentifier: FilterIndicatorProgrammaticallyCell.identifier)
        
//        tableView.register(UINib(nibName: "\(FilterMonitorObjectCell.classForCoder())", bundle: nil), forCellReuseIdentifier: "\(FilterMonitorObjectCell.classForCoder())")
//        tableView.register(UINib(nibName: FilterIndicatorCell.identifier, bundle: nil), forCellReuseIdentifier: FilterIndicatorCell.identifier)
        
        tableView.backgroundColor = .lightGray
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "指標設定"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(clickCancelToSetting))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "確定", style: .plain, target: self, action: #selector(clickConfirmToSetting))
    }
    
    @objc
    func clickCancelToSetting(_ sender: UIButton) {
        if let delegate = isChangeDelegate {
            delegate.getFilterIsChange(isChange: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func clickConfirmToSetting(_ sender: UIButton) {
//        showCustomAlert()
        
//        guard let viewModel = filterIndicatorViewModel else { return }
//        if !viewModel.hasAtLeastOneFilterEnabled() {
//            showCustomAlert()
//            return
//        }
//        
//        filterIndicatorViewModel?.saveIndicatorSetting()
//        if let delegate = isChangeDelegate {
//            delegate.getFilterIsChange(isChange: true)
//        }
//        navigationController?.popViewController(animated: true)
    }
    
//    private func showBasicIndicatorCustomAlert() {
//        let customAlert = AlertBuilder()
//            .setButtonTitle("知道啦！！")
//            .setTitle( Constant.recycleTipTitleText)
//            .setContent(Constant.recycleTipMessageText)
//            .build()
//        customAlert.modalPresentationStyle = .overFullScreen
//        self.present(customAlert, animated: false)
//    }
    
//    private func showCustomAlert() {
//        let customAlert = AlertBuilder()
//            .setButtonTitle("我知道了")
//            .setContent("請至少選擇一個基本條件")
//            .build()
//        customAlert.modalPresentationStyle = .overFullScreen
//        self.present(customAlert, animated: false)
//    }

    func setupNoticeView() {
        let noticeLabel = UILabel()
        noticeLabel.text = "＊指標設定不影響ETF存股"
        noticeLabel.textColor = .black
        noticeLabel.font = .systemFont(ofSize: 16)
        noticeLabel.textAlignment = .center
        noticeView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.centerX.centerY.equalToSuperview()
        }
//        noticeView.isHidden = filterIndicatorViewModel?.pageType == .customGroup
    }

}

extension FilterIndicatorProgrammaticallyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0 : return 1
//        case 1 : return 4
//        case 2 : return 6
//        default:
//            return 0
//        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mock = MonitorObject(currentOption: .TW50,
                                 monitorOption: [MonitorObjectType.TW50])
        let indicatorText = [IndicatorType.moatPriceAlgorithm.rawValue, IndicatorType.mediumAndLargeStocks.rawValue, IndicatorType.makeMoney.rawValue, ]
        /// 使用單一 cell 測試UI
        let indicatorCell = tableView.dequeueReusableCell(withIdentifier: FilterIndicatorProgrammaticallyCell.identifier,
                                                          for: indexPath) as! FilterIndicatorProgrammaticallyCell
//        indicatorCell.selectionStyle = .none
//        indicatorCell.setupCell(options:  [.TW50], currentOption: .TW50)
        indicatorCell.nameLabel.text = indicatorText[indexPath.row]
        return indicatorCell
        
        /// 使用單一 cell 測試UI
        
//        tableView.register(UINib(nibName: "\(FilterMonitorObjectCell.classForCoder())", bundle: nil), forCellReuseIdentifier: "\(FilterMonitorObjectCell.classForCoder())")
//        tableView.register(UINib(nibName: FilterIndicatorCell.identifier, bundle: nil), forCellReuseIdentifier: FilterIndicatorCell.identifier)
        
        
        // 用下方的 switch case 去產生 cell 的話就算有值也會是空白畫面，使用單一 cell 就不會有這問題
//        switch tableView.numberOfSections {
//        case 0 :
//            let monitorCell = tableView.dequeueReusableCell(withIdentifier: FilterMonitorObjectProgrammaticallyCell.identifier(),
//                                                            for: indexPath) as! FilterMonitorObjectProgrammaticallyCell
//            monitorCell.setupCell(options: mock.monitorOption,
//                           currentOption: mock.currentOption)
//            return monitorCell
//        case 1 :
//            let indicatorCell = tableView.dequeueReusableCell(withIdentifier: FilterIndicatorProgrammaticallyCell.identifier(),
//                                                              for: indexPath) as! FilterIndicatorProgrammaticallyCell
//            indicatorCell.selectionStyle = .none
//            indicatorCell.nameLabel.text = "Section 2"
//            return indicatorCell
//        case 2 :
//            let indicatorCell = tableView.dequeueReusableCell(withIdentifier: FilterIndicatorProgrammaticallyCell.identifier(),
//                                                              for: indexPath) as! FilterIndicatorProgrammaticallyCell
//            indicatorCell.selectionStyle = .none
//            indicatorCell.nameLabel.text = "Section 3"
//            return indicatorCell
//        default:
//            return UITableViewCell()
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 28))
        headerView.backgroundColor = .lightGray
        let titleLabel = UILabel()
//        titleLabel.text = dataSources?[section].header
        titleLabel.text = mockHeader[section].description
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        let conditionLable = UILabel()
//        conditionLable.text = dataSources?[section].headerTip
        conditionLable.text = "conditionLabel"
        conditionLable.textColor = .black
        conditionLable.font = .systemFont(ofSize: 12)
        headerView.addSubview(conditionLable)
        conditionLable.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard indexPath.section == 0 && filterIndicatorViewModel?.isIncludedMonitor == true  else { return tableView.rowHeight }
        return 72
    }
}



extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    // https://gist.github.com/Deub27/5eadbf1b77ce28abd9b630eadb95c1e2
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        
        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}


protocol CellIdentifier {}

extension CellIdentifier {
    
    static func identifier() -> String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CellIdentifier {}
