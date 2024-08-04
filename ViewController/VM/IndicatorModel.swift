//
//  FilterIndicatorModel.swift
//  EmilyFixedStock
//
//  Created by Oldkay Chang on 2019/2/16.
//  Copyright © 2019年 CMoney. All rights reserved.
//

import Foundation

enum IndicatorType: String, Codable, CaseIterable {
    case belowCheapPrice
    case belowSamePrice
    case notRichCycle
    case qualifiedPhysical
    case aboveYields
    case makeMoney
    case dispathStockDividend
    case listedAboveTenYears
    case mediumAndLargeStocks
    case moatPriceAlgorithm
    
//    var indicatorName: String {
//        switch self {
//        case .belowCheapPrice: return Constant.belowCheapPriceText
//        case .belowSamePrice: return Constant.belowSamePriceText
//        case .notRichCycle: return Constant.notRichCycleText
//        case .qualifiedPhysical: return Constant.qualifiedPhysicalText
//        case .aboveYields: return Constant.aboveYieldsText
//        case .makeMoney: return Constant.makeMoneyText
//        case .dispathStockDividend: return Constant.dispathStockDividendText
//        case .listedAboveTenYears: return Constant.listedAboveTenYearsText
//        case .mediumAndLargeStocks: return Constant.mediumAndLargeStocksText
//        case .moatPriceAlgorithm: return "適用紅綠燈評價股"
//        }
//    }
}

struct IndicatorModel: Codable {
    let title: String
    var monitorObject: MonitorObject? = nil
    var options: [IndicatorOption] = []
    
    init(title: String, monitorObject: MonitorObject? = nil, options: [IndicatorOption] = []) {
        self.title = title
        self.monitorObject = monitorObject
        self.options = options
    }
}

struct MonitorObject: Codable {
    var currentOption: MonitorObjectType
    var monitorOption: [MonitorObjectType]
    init(currentOption: MonitorObjectType = .TW50, monitorOption: [MonitorObjectType] = []) {
        self.currentOption = currentOption
        self.monitorOption = monitorOption
    }
}

enum MonitorObjectType: Int, Codable {
    case TW50
    case allTW
    
    var mainWord: String {
        switch self {
        case .TW50:
            return "台灣50 "
        case .allTW:
            return "全台股上市櫃 "
        }
    }
    
    var subWord: String {
        switch self {
        case .TW50:
            return "(最大的50家公司)"
        case .allTW:
            return ""
        }
    }
}

struct IndicatorOption: Codable {
    let indicator: IndicatorType
    var name: String {
        return indicator.rawValue
    }
    var tipDetail: TipDetail?
    var authLimited: Bool = false
    var isFilterOn: Bool?
    
    init(indicator: IndicatorType, authLimited: Bool, isFilterOn: Bool? = false, tipDetail: TipDetail? = nil) {
        self.indicator = indicator
        self.authLimited = authLimited
        self.isFilterOn = isFilterOn
        self.tipDetail = tipDetail
    }
}

struct TipDetail: Codable {
    let showTip: Bool
    var tipTilte: String?
    var tipDescription: String?
    
    init(isShow: Bool, title: String? = nil, description: String? = nil) {
        showTip = isShow
        tipTilte = title
        tipDescription = description
    }
}
