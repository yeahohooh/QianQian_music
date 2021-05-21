//
//  GenreView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/20.
//

import UIKit

class GenreView: BaseView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 // 最小行间距
        layout.minimumInteritemSpacing = 10 // 最小列间距
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30) // 内边距
        return layout
    }()
    
    private lazy var collectView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "genreCell")
        return view
    }()
    
    var itemSize: CGSize? {
        didSet {
            guard let size = itemSize else {
                return
            }
            flowLayout.itemSize = size
        }
    }
    
    var genreModel: HomeBannerData? {
        didSet {
            titleLabel.text = genreModel?.module_name ?? ""
            collectView.reloadData()
        }
    }
    
    override func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        self.addSubview(collectView)
        collectView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func moreClick() {
        
    }
    
}

extension GenreView: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreModel?.module_nums ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath)
        let label = UILabel(frame: cell.contentView.frame)
        label.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        label.text = genreModel?.result?[indexPath.row].categoryName ?? ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
