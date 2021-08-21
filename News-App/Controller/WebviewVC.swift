//
//  WebviewVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit
import WebKit
import CoreData

class WebviewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    //MARK: - INSTANCE OF MODEL
    var articles: Articles?
    var bookmarks = [Bookmarks]()
    
    var url: String? = nil
    var titleName: String? = nil
    var sourceName : String? = nil
    var urlImage : String? = nil
    var activityIndicator = UIActivityIndicatorView()
    
    
    //MARK:- IB OUTLESTS
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    
    
    
    //MARK: - CORE DATA
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    let saveContent: () = (UIApplication.shared.delegate as!
                            AppDelegate).saveContext()
    
    override func viewDidLoad() {
        
        fetchData()
        super.viewDidLoad()
        configureWebview()
        configureIndicator()
        
        //MARK: - LINK FOR IMG
        configureURL()
    }
    
    func configureWebview(){
        webView.navigationDelegate = self
        webView.uiDelegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(webView)
    }
    
    func configureIndicator(){
        activityIndicator.color = .red
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
    }
    
    func configureURL(){
        guard let request = URL(string: url ?? "text") else {
            return
        }
        webView.load(URLRequest(url: request))
    }
    //MARK: - CHECHKING FOR BOOKMARK EXISTINCE
    func fetchData() {
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "titleName == %@", titleName!)
        
        if (try? context.fetch(fetchRequest))?.first != nil {
            bookmarkButton.image = UIImage(systemName: "bookmark.fill")
        }
        do {
            let bookmarks = try context.fetch(fetchRequest)
            self.bookmarks = bookmarks
            
        } catch {}
    }
    
    
    @IBAction func buttonClicked(_ sender: UIBarButtonItem) {
        //  MARK: - TOGGLING
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "titleName == %@", titleName!)
        
        if (try? context.fetch(fetchRequest))?.first == nil {
            bookmarkButton.image = UIImage(systemName: "bookmark.fill")
            let bookmark = Bookmarks(context: context)
            bookmark.urlToImage = urlImage
            bookmark.source = sourceName
            bookmark.titleName = titleName
            bookmark.urlLink = url
            bookmarks.append(bookmark)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
            
        } else {
            do {
                bookmarkButton.image = UIImage(systemName: "bookmark")
                let objects = try context.fetch(fetchRequest)
                for object in objects {
                    context.delete(object)
                }
                try context.save()
            } catch _ {
                print("error")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    //MARK: - ANIMATION 
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
