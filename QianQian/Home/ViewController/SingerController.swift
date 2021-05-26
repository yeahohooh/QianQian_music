//
//  SingerController.swift
//  QianQian
//
//  Created by 李博 on 2021/5/21.
//

import UIKit
import HandyJSON

class SingerController: BaseController {
    
    lazy var singerTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.register(SingerAreaCell.self, forCellReuseIdentifier: "singerAreaCell")
        table.register(SingerCell.self, forCellReuseIdentifier: "singerCell")
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.bottom.equalToSuperview()
        }
        return table
    }()
    
    var artistListModel: artist_data? {
        didSet {
            singerTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.5) {
            rootVC?.audioBottom.frame = CGRect(x: 0, y: screenHeight + 20, width: screenWidth, height: audioBottomHeight)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "歌手"
        
        let itemLeft = UIBarButtonItem(image: UIImage(named: "nav_back_black"), style: .plain, target: self, action: #selector(navBack))
        itemLeft.tintColor = .black
        navigationItem.leftBarButtonItem = itemLeft
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
        loadData()
    }
    
    @objc private func navBack() {
        navigationController?.popViewController(animated: true)
    }
 
    private func loadData() {
        ApiProvider.request(QianApi.artistlist(appid: 16073360,artistGender: "",artistRegion: "", pageNo: 1, pageSize: 50, sign: "109decc51723d50d1c8f1a613d93f48d", timestamp: 1621583102555307)) { [weak self] (result) in
            let jsonString = String(data: result.value!.data, encoding: .utf8)
            if let model = JSONDeserializer<ResponseData<artist_data>>.deserializeFrom(json: jsonString) {
                self?.artistListModel = model.data
            }
        }
    }
}

extension SingerController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return artistListModel?.recommend?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "热门"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singerAreaCell", for: indexPath) as! SingerAreaCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singerCell", for: indexPath) as! SingerCell
            cell.artistModel = artistListModel?.recommend?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
}
