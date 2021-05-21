//
//  SearchController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/6.
//

import UIKit

class SearchController: BaseController {
    
    private lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.gray, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    private lazy var searchBar: SearchBarView = {
        let search = SearchBarView()
        return search
    }()
    
    private lazy var historyLab: UILabel = {
        let lab = UILabel()
        lab.text = "历史记录"
        lab.textColor = .lightGray
        return lab
    }()
    
    private lazy var historyArr: Array<UIView> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.didSearch = { [weak self] in
            self?.reDrawHistory()
        }
        
        setupHistory()
    }
    
    override func setupUI() {
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(cancelBtn)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(cancelBtn.snp.left).offset(-10)
            make.height.equalTo(35)
        }
        
        view.addSubview(historyLab)
        historyLab.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.equalTo(searchBar)
        }
    }
    
    func setupHistory() {
        view.layoutIfNeeded()
        var lastX = historyLab.frame.origin.x, lastY = historyLab.frame.maxY
        let maxWidth = self.view.frame.width - (lastX * 2)
        for history in searchBar.searchHistory {
            // father view
            let size = NSString(string: history).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)])
            let width = size.width + 40
            if lastX + 10 + width > maxWidth {
                lastX = historyLab.frame.origin.x
                lastY += 40
            }
            let historyView = UIView(frame: CGRect(x: lastX + 10.0, y: lastY + 20.0, width: width, height: 30.0))
            historyView.layer.cornerRadius = 15
            historyView.layer.masksToBounds = true
            historyView.layer.borderWidth = 1
            historyView.layer.borderColor = UIColor.lightGray.cgColor
            view.addSubview(historyView)
            lastX = historyView.frame.maxX
            // left btn
            let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: width - 30, height: historyView.frame.height))
            leftBtn.setTitle(history, for: .normal)
            leftBtn.setTitleColor(.gray, for: .normal)
            leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
            leftBtn.addTarget(self, action: #selector(historyClick(_:)), for: .touchUpInside)
            historyView.addSubview(leftBtn)
            // right btn
            let rightBtn = UIButton(frame: CGRect(x: leftBtn.frame.maxX, y: 0, width: 30, height: historyView.frame.height))
            rightBtn.titleLabel?.text = history // useless
            rightBtn.setBackgroundImage(UIImage(named: "history_cancel"), for: .normal)
            rightBtn.addTarget(self, action: #selector(historyDelete(_:)), for: .touchUpInside)
            historyView.addSubview(rightBtn)
            
            historyArr.append(historyView)
        }
    }
    
    deinit {
        
    }
    
}

extension SearchController {
    @objc func cancelClick() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func historyClick(_ btn: UIButton) {
        
    }
    
    @objc func historyDelete(_ btn: UIButton) {
        searchBar.searchHistory.removeAll(where: { $0 == btn.titleLabel?.text })
        UserDefaults.standard.setValue(searchBar.searchHistory, forKey: "searchHistory")
        reDrawHistory()
    }
    
    func reDrawHistory() {
        for view in historyArr {
            view.removeFromSuperview()
        }
        historyArr.removeAll()
        setupHistory()
    }
}
