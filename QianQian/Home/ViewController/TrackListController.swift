//
//  TrackListController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/23.
//

import UIKit
import HandyJSON

class TrackListController: BaseController {
    
    private lazy var headerImageView: UIImageView = {
        let header = UIImageView()
        return header
    }()
    
    private lazy var bgScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var actionBar: TrackActionBarView = {
        let action = TrackActionBarView()
        return action
    }()
    
    var trackListModel: trackListData? {
        didSet {
            let url = URL(string: trackListModel?.pic ?? "")
            headerImageView.kf.setImage(with: url)
            actionBar.titleStr = trackListModel?.title
            actionBar.subTitleStr = "\(trackListModel?.trackCount ?? 0)" + "首单曲"
            setupListContent()
            view.layoutIfNeeded()
            let lastView = view.viewWithTag((trackListModel?.trackList?.count ?? 0) - 1)
            bgScrollView.contentSize = CGSize(width: 0, height: (lastView?.frame.maxY ?? screenHeight) + audioBottomHeight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        loadData()
    }
    
    private func loadData() {
        ApiProvider.request(QianApi.tracklist(id: 280658, appid: 16073360, sign: "31d70ac1cdfaea744074871874eb162f", timestamp: 1619168471354281, pageNo: 1, pageSize: 50, type: 0)) { [weak self] (result) in
            let jsonString = String(data: result.value!.data, encoding: .utf8)
            if let model = JSONDeserializer<ResponseData<trackListData>>.deserializeFrom(json: jsonString) {
                self?.trackListModel = model.data
            }
        }
    }
    
    override func setupUI() {
        let navHeight = (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.size.height
        
        view.addSubview(bgScrollView)
        bgScrollView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        bgScrollView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(-navHeight)
            make.centerX.equalTo(bgScrollView)
            make.width.equalTo(screenWidth)
            make.height.equalTo((screenHeight + navHeight) / 2)
        }
        
        let cornerLabel = UILabel()
        cornerLabel.backgroundColor = .white
        let corner = UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue)
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        cornerLabel.layer.mask = maskLayer
        bgScrollView.addSubview(cornerLabel)
        cornerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headerImageView.snp.bottom).offset(-20)
            make.left.right.equalTo(headerImageView)
            make.height.equalTo(100)
        }
        
        bgScrollView.addSubview(actionBar)
        actionBar.snp.makeConstraints { (make) in
            make.top.equalTo(cornerLabel).offset(10)
            make.left.right.equalTo(headerImageView)
            make.height.equalTo(120)
        }
    }
    
    private func setupListContent() {
        guard let trackList = trackListModel?.trackList else {
            return
        }
        for i in 0..<trackList.count {
            let track = trackList[i]
            let songView = TrackSongView()
            songView.trackModel = track
            songView.tag = i
            bgScrollView.addSubview(songView)
            songView.snp.makeConstraints { (make) in
                make.width.equalTo(screenWidth)
                make.height.equalTo(60)
                make.centerX.equalTo(bgScrollView)
                make.top.equalTo(actionBar.snp.bottom).offset(i * 75)
            }
        }
    }

}
