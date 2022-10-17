//
//  ViewModel.swift
//  Combine-Example
//
//  Created by 순진이 on 2022/10/17.
//

import Combine

class ViewModel {
    var content = PassthroughSubject<String, Never>()
    
    func request() {
        
        Task {
            let quote = try await APIService().getQuotes()
            content.send(quote.content)
        }
    }
}
