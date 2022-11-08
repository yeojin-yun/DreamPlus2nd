//
//  ViewController.swift
//  Combine-Example
//
//  Created by 순진이 on 2022/10/17.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton(type: .system)
    private let viewModel = ViewModel()
    
    var content = PassthroughSubject<String, Never>()
    //Never : Error가 절대 발생하지 않을 것이다.
    var cancellable = Set<AnyCancellable>()
    //[AnyCancellable]() 도 작동함 -> 공식 문서에서 Set으로 쓰니까 그렇게 만들자

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        combineTest()
    }
    
    func combineTest() {
        //sink -> cancellable을 반환함 (찌꺼기와 유사)
        //찌꺼기를 쓰레기통에 넣어줘야 함
        viewModel.content
            .receive(on: DispatchQueue.main)
            .map { Optional($0) }
            .assign(to: \.label.text, on: self) //keypath expression
            .store(in: &cancellable)
    }
}

extension ViewController {
    @objc func buttonTapped(_ sender: UIButton) {
        print(#function)
//        APIService().getQuote { result in
//            switch result {
//            case .success(let quote):
//                self.label.text = quote.content
//                self.content.send(quote.content) //신호를 보냄
//            case .failure(let error):
//                self.label.text = error.localizedDescription
//            }
//        }
        viewModel.request()
    }
}

//MARK: -UI
extension ViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        label.text = "label"
        label.numberOfLines = 0
        label.textAlignment = .center
        button.setTitle("button", for: .normal)
    }
    
    final private func addTarget() {
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        [label, button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
}

