//
//  OrderModel.swift
//  DataBinding-Example
//
//  Created by 순진이 on 2022/11/22.
//

import Foundation

struct OrderHistoryModel: Codable {
    let orderData: [OrderHistory]
}

struct OrderHistory: Codable {
    let id, year: Int
    var month: Int
    let createdAt, productName: String
    let addressID: Int
    let invoiceNumber: String
    let deliveryStageID: Int
    let address, userInfo: [String]
    let orderNumber: String
    var photos: [String]
    let orderType: [Int]
    let price: Int

    enum CodingKeys: String, CodingKey {
        case id, year, month, createdAt
        case productName = "product_name"
        case addressID = "address_id"
        case invoiceNumber = "invoice_number"
        case deliveryStageID = "delivery_stage_id"
        case orderNumber = "paycode"
        case address, photos
        case userInfo = "user"
        case price = "pay"
        case orderType = "type"
    }
}
