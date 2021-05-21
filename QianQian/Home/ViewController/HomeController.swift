//
//  HomeController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/6.
//

import UIKit
import HandyJSON
import ZCycleView
import Kingfisher

class HomeController: BaseController {
    
    private var homeData: [HomeBannerData]?
    
    private lazy var bgScrollView: UIScrollView = {
        let bg = UIScrollView(frame: view.bounds)
        bg.backgroundColor = .white
        bg.delegate = self
        bg.showsVerticalScrollIndicator = false
        bg.showsHorizontalScrollIndicator = false
        return bg
    }()
    
    private lazy var searchBanner: UIButton = {
        let search = UIButton()
        search.backgroundColor = .white
        search.setTitle("搜索音乐~歌手~专辑", for: .normal)
        search.setTitleColor(.gray, for: .normal)
        search.addTarget(self, action: #selector(searchClick), for: .touchUpInside)
        search.layer.shadowColor = UIColor.lightGray.cgColor
        search.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        search.layer.shadowOpacity = 0.6
        search.layer.shadowRadius = 1
        search.clipsToBounds = false
        return search
    }()
    
    private lazy var cycleBanner: ZCycleView = {
        let width = view.bounds.width - 20
        let cycleView = ZCycleView()
        cycleView.itemZoomScale = 1.5
        cycleView.timeInterval = 5
        cycleView.itemSpacing = 10
        cycleView.initialIndex = 1
        cycleView.isAutomatic = true
        cycleView.reloadItemsCount(10)
        cycleView.delegate = self
        cycleView.itemSize = CGSize(width: width - 150, height: (width - 150) / 2.3333)
        return cycleView
    }()
    
    private lazy var albumView: AlbumView = {
        let album = AlbumView()
        album.currentAlbumType = .new
        album.showMore = true
        album.albumDelegate = self
        return album
    }()
    
    private lazy var musicListView: AlbumView = {
        let list = AlbumView()
        list.currentAlbumType = .list
        list.showMore = true
        list.albumDelegate = self
        return list
    }()
    
    private lazy var genreView: GenreView = {
        let genre = GenreView()
        return genre
    }()
    
    private lazy var singerView: SingerView = {
        let singer = SingerView()
        return singer
    }()
    
    private lazy var newSongView: NewSongView = {
        let song = NewSongView()
        return song
    }()
    
    private lazy var selectedVideoView: SelectedVideoView = {
        let video = SelectedVideoView()
        return video
    }()
    
    private lazy var musicStyleOne: AlbumView = {
        let one = AlbumView()
        one.currentAlbumType = .list
        one.albumDelegate = self
        return one
    }()
    
    private lazy var musicStyleTwo: AlbumView = {
        let two = AlbumView()
        two.currentAlbumType = .list
        two.albumDelegate = self
        return two
    }()
    
    private lazy var musicStyleThree: AlbumView = {
        let three = AlbumView()
        three.currentAlbumType = .list
        three.albumDelegate = self
        return three
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        rootVC?.audioBottom.frame = CGRect(x: 0, y: screenHeight - audioBottomHeight - CGFloat(tabBarHeight), width: screenWidth, height: audioBottomHeight)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tabBarController?.tabBar.shadowImage = UIImage()
    }
    
    private func loadData() {
//        let timestamp = Int64(floor(NSDate().timeIntervalSince1970 * 1000000))
        ApiProvider.request(QianApi.home(appid: 16073360, sign: "54a31b9a3223b64c6c4385dfe269ced6", timestamp: 1617801499232315)) { [weak self] (result) in
            let jsonString = String(data: result.value!.data, encoding: .utf8)
            if let model = JSONDeserializer<ResponseData<[HomeBannerData]>>.deserializeFrom(json: jsonString) {
                self?.homeData = model.data
                self?.cycleBanner.reloadItemsCount(model.data?[0].result?.count ?? 0)
                self?.albumView.albumModel = model.data?[2]
                self?.musicListView.albumModel = model.data?[3]
                self?.genreView.genreModel = model.data?[4]
                self?.singerView.singerModel = model.data?[5]
                self?.newSongView.newSongModel = model.data?[6]
                self?.selectedVideoView.videoModel = model.data?[7]
                self?.musicStyleOne.albumModel = model.data?[8]
                self?.musicStyleTwo.albumModel = model.data?[9]
                self?.musicStyleThree.albumModel = model.data?[10]
                self?.view.layoutIfNeeded()
                self?.bgScrollView.contentSize = CGSize(width: 0, height: (self?.musicStyleThree.frame.maxY ?? screenHeight) + audioBottomHeight + tabBarHeight)
            }
        }
    }
    
    override func setupUI() {
        view.addSubview(bgScrollView)
        
        bgScrollView.addSubview(searchBanner)
        searchBanner.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(bgScrollView.frame.size.width - 50)
        }

        bgScrollView.addSubview(cycleBanner)
        cycleBanner.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(searchBanner.snp.bottom).offset(20)
            $0.width.equalToSuperview()
            $0.height.equalTo(cycleBanner.snp.width).dividedBy(2.3333)
        }
        // 歌手 榜单 分类
        setupCategoryBanner()
        // 最新专辑
        setupAlbumBanner()
        // 推荐歌单
        setupMusicListBanner()
        // 流派
        setupGenreBanner()
        // 推荐歌手
        setupSingerBanner()
        // 新歌推荐
        setupNewSongBanner()
        // 精选视频
        setupSelectedVideoBanner()
        // 音乐风格
        setupMusicStyleBanner()
    }
    
    // second banner
    private func setupCategoryBanner() {
        let btnImages = ["home_singer","home_list","home_classify"]
        let btnTitles = ["歌手","榜单","分类歌单"]
        let width = screenWidth / 7
        for index in 0..<3 {
            let btn = UIButton()
            let image = UIImage(named: btnImages[index])
            btn.setImage(image?.scaleImage(scaleSize: 1.5), for: .normal)
            btn.setTitle(btnTitles[index], for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.tag = 10 + index
            btn.addTarget(self, action: #selector(categoryClick(_:)), for: .touchUpInside)
            
            btn.ButtonImageTop(5.0)
            bgScrollView.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.top.equalTo(cycleBanner.snp.bottom).offset(20)
                make.left.equalTo(width * CGFloat(index*2 + 1))
                make.width.equalTo(width*1.2)
                make.height.equalTo(width*1.2)
            }
        }
    }
    
    // album banner
    private func setupAlbumBanner() {
        let singerBtn = view.viewWithTag(10) as! UIButton
        bgScrollView.addSubview(albumView)
        albumView.snp.makeConstraints {
            $0.top.equalTo(singerBtn.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
        
    }
    
    // music list banner
    private func setupMusicListBanner() {
        bgScrollView.addSubview(musicListView)
        musicListView.snp.makeConstraints {
            $0.top.equalTo(albumView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
    }
    
    // genre banner
    private func setupGenreBanner() {
        bgScrollView.addSubview(genreView)
        genreView.snp.makeConstraints {
            $0.top.equalTo(musicListView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
        let width = (screenWidth - 20) / 5
        genreView.itemSize = CGSize(width: width, height: 30)
    }
    
    // singer banner
    private func setupSingerBanner() {
        bgScrollView.addSubview(singerView)
        singerView.snp.makeConstraints {
            $0.top.equalTo(genreView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(220)
        }
    }
    
    // newSong banner
    private func setupNewSongBanner() {
        bgScrollView.addSubview(newSongView)
        newSongView.snp.makeConstraints {
            $0.top.equalTo(singerView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(240)
        }
    }
    
    // selectedVideo banner
    private func setupSelectedVideoBanner() {
        bgScrollView.addSubview(selectedVideoView)
        selectedVideoView.snp.makeConstraints {
            $0.top.equalTo(newSongView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
    }
    
    // musicStyle banner
    private func setupMusicStyleBanner() {
        bgScrollView.addSubview(musicStyleOne)
        musicStyleOne.snp.makeConstraints {
            $0.top.equalTo(selectedVideoView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
        
        bgScrollView.addSubview(musicStyleTwo)
        musicStyleTwo.snp.makeConstraints {
            $0.top.equalTo(musicStyleOne.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
        
        bgScrollView.addSubview(musicStyleThree)
        musicStyleThree.snp.makeConstraints {
            $0.top.equalTo(musicStyleTwo.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(view)
            $0.height.equalTo(200)
        }
    }
    
    // 搜索点击
    @objc func searchClick() {
        navigationController?.pushViewController(SearchController(), animated: false)
    }
    
    // 中间三个按钮点击
    @objc func categoryClick(_ sender: UIButton) {
        switch sender.tag {
        case 10: // 歌手
            print("singer click")
            break
        case 11: // 榜单
            print("list click")
            break
        case 12: // 分类歌单
            print("category click")
            break
        default:
            break
        }
    }
    
}

extension HomeController: UIScrollViewDelegate {
    
}

extension HomeController: ZCycleViewProtocol {
    func cycleViewRegisterCellClasses() -> [String : AnyClass] {
        return ["cycleCell": CycleCell.self]
    }
    
    func cycleViewConfigureCell(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, realIndex: Int) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cycleCell", for: indexPath) as! CycleCell
        let url = URL(string: homeData?[0].result?[realIndex].pic ?? "")
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    func cycleViewDidSelectedIndex(_ cycleView: ZCycleView, index: Int) {
        let albumController = TrackListController()
        navigationController?.pushViewController(albumController, animated: true)
    }
    
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.isHidden = true
    }
    
}

extension HomeController: AlbumViewDelegate {
    // 点击专辑
    func didClickAlbum() {
        navigationController?.pushViewController(TrackListController(), animated: true)
    }
}
