//
//  SearchBarView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/6.
//

import UIKit

class SearchBarView: BaseView {
    
    typealias searchClosure = () -> Void
    
    var didSearch: searchClosure = {}
    
    var searchHistory: Array<String> = {
        let history = UserDefaults.standard.stringArray(forKey: "searchHistory")
        if history?.count ?? 0 > 0 {
            return history!
        } else {
            return Array()
        }
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "搜索音乐，歌手，专辑"
        textField.borderStyle = .roundedRect
        textField.tintColor = .gray
        textField.leftViewMode = .always
        textField.leftView = leftView
        textField.rightViewMode = .always
        textField.rightView = rightView
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var leftView: UIImageView = {
        let leftView = UIImageView()
        leftView.image = UIImage(named: "search")
        return leftView
    }()
    
    private lazy var rightView: UIView = {
        let rightView = UIView()
        rightView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return rightView
    }()
    
    private lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.isHidden = true
        rightBtn.setBackgroundImage(UIImage(named: "search_cancel"), for: .normal)
        rightBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return rightBtn
    }()
    
    override func setupUI() {
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else {
            return true
        }
        if text.count > 0 {
            let history = UserDefaults.standard.stringArray(forKey: "searchHistory")
            if history?.count ?? 0 > 0 {
                searchHistory = history!
            }
            if searchHistory.contains(where: { $0.caseInsensitiveCompare(text) == .orderedSame }) {
                searchHistory.removeAll(where: { $0 == text } )
            }
            searchHistory.append(text)
            UserDefaults.standard.setValue(searchHistory, forKey: "searchHistory")
            
            didSearch()
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            rightBtn.isHidden = false
        } else {
            rightBtn.isHidden = true
        }
    }
    
    @objc func cancelClick() {
        searchTextField.text = ""
        rightBtn.isHidden = true
    }
    
}
