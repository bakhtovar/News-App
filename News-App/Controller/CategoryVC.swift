//
// CategoryVc.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
import Foundation
import UIKit
import SkeletonView
import Kingfisher
import CoreData
class CategoryVC: UIViewController {
  //MARK: - INSTANCE OF MODEL
  var articles: Articles?
  var catPass: PassUrl!

  var bookmarks = [Bookmarks]()
  var news = [News]()
  let const = K()
  let dbModel = CategoryDBModel()
  // MARK: - VARIABLES
  var titleName: String?
  var urlString: String?
  var sourceId : String?
  var labelText: String?
  var pageNumber: Int = 1
  var sourceName: String?
  var buttonId: String?
  var refresh = UIRefreshControl()
  //MARK:- IB OUTLET
  @IBOutlet weak var myTableView: UITableView!
  //MARK: - CORE DATA
  let context = (UIApplication.shared.delegate as!
          AppDelegate).persistentContainer.viewContext
  let saveContent: () = (UIApplication.shared.delegate as!
              AppDelegate).saveContext()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTable()
    //MARK:- ASSIGNING TITLE
    if titleName != nil {
      self.title = titleName
    } else {
      self.title = sourceName
    }
    //MARK: - PULL TO REFRESH
    pullToRefresh()
    //MARK: - USAGE OF SKELETON
    skeletonUsage()
    //MARK:- MAKING INSTANCE OF MODEL PASS URL
    catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)
    
    //MARK: - GETTING DATA FROM JSON
    APICall.shared.fetchData(category: catPass) { (response) in
        DispatchQueue.main.async { [self] in
            self.articles = response
        self.myTableView.stopSkeletonAnimation()
        self.myTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        if self.labelText != "" && self.sourceName == nil && self.titleName == nil {
          if self.articles?.articles.count == 0 {
            self.title = "No results for \(self.labelText ?? "")"
          } else if self.articles?.articles.count != 0 {
            self.title = "Results for \(self.labelText ?? "")"
          }
        }
      }
    }
  }
    
    
//    func fetchData(id: String) {
//        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
//        do {
//            fetchRequest.predicate = NSPredicate(format: "idButton = %@", id)
//            let news = try context.fetch(fetchRequest)
//            print(id)
//            self.news = news
////            print(News.self)
//            myTableView.reloadData()
//            myTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
//
//        } catch {}
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            fetchData(id: buttonId!)
//        }

    
  func configureTable() {
    myTableView.delegate = self
    myTableView.dataSource = self
    myTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
    myTableView.register(UINib(nibName: "SpinnerCell", bundle: nil), forCellReuseIdentifier: "SpinnerCell")
  }
  func pullToRefresh() {
    refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
    myTableView?.addSubview(refresh)
  }
  func skeletonUsage() {
    myTableView.isSkeletonable = true
    myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
    myTableView.startSkeletonAnimation()
    myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
  }
  //MARK: - REFRESHING FUNC
  @objc func refreshData (refreshControl: UIRefreshControl) {
    catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)
    APICall.shared.fetchData( category: catPass) { (response) in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.articles = response
        self.myTableView.reloadData()
        self.refresh.endRefreshing()
      }
    }
  }
}


extension CategoryVC: UITableViewDelegate, SkeletonTableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles?.articles.count ?? 10
  }
  func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles?.articles.count ?? 10 
  }
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return "articleCell"
  }
  //MARK: - ADDING DATA TO AN EMPTY CELL
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if pageNumber < const.total && indexPath.row + 1 == (articles?.articles.count) && (articles?.articles.count) ?? 10  >= const.totalPage {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SpinnerCell", for: indexPath) as! SpinnerCell
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
       // let article = news[indexPath.row]
        let article = articles?.articles[indexPath.row]
        if article?.urlToImage == nil {
          cell.imageIcon.isHidden = true
          cell.imageWidth.constant = 0
        }
        cell.titleLabel.text = article?.title
        cell.urlLabel.text = article?.source.name
        cell.imageIcon.kf.indicatorType = .activity
        if let image = URL(string: article?.urlToImage ?? "") {
          cell.imageIcon.kf.setImage(with: image, placeholder: nil)
        }
      
      return cell
    }
  }
  // MARK: - UPDATING THE PAGE INT WHEN TABLEVIEW REACHES THE BOTTOM
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastItem = (articles?.articles.count ?? 2)
    if pageNumber < const.total && indexPath.row + 1 == lastItem && articles?.articles.count ?? 2 >= const.totalPage {
      pageNumber += 1
      catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)
        APICall.shared.fetchData(category: catPass) { (response) in
        DispatchQueue.main.async {
          self.articles?.articles.append(contentsOf: response.self.articles)
          self.myTableView.reloadData()
        }
      }
    }
  }
  //MARK: - SENDING DATA TO WEBVIEWVC
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(identifier: "WebviewVC") as! WebviewVC
    vc.url = articles?.articles[indexPath.row].url
    vc.sourceName = articles?.articles[indexPath.row].source.name?.uppercased()
    vc.titleName = articles?.articles[indexPath.row].title
    vc.urlImage = articles?.articles[indexPath.row].urlToImage
    self.navigationController?.pushViewController(vc, animated: true)
  }
  //MARK:- CELL'S HEIGHT
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
