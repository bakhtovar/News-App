//
//  SourcesVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit
import SkeletonView
import CoreData

class SourcesVC: UIViewController {
    @IBOutlet weak var sourcesSearch: UISearchBar!
    @IBOutlet weak var sourcesCollectionView: UICollectionView!
    

    // MARK: - MAKING AN INSTANCE OF STRUCTS
    var category = CategoriesBrain()
    var sources: Sources?
    var sourcesDB = [SourceDB]()
    let dbObject = SourcesDBModel()
    var network : Bool = false
    //MARK: - CREATE A COPY FOR FILTERING
    var filteredData: Sources?
    
    let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
        let saveContent: () = (UIApplication.shared.delegate as!
                    AppDelegate).saveContext()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureNavbarAndSearchBar()
        configureCollectionView()
    
      //MARK: - GETTING DATA FROM JSON
        APICall.shared.getSources { (response) in
            DispatchQueue.main.async {
                self.sources = response
                
                for i in 0..<(self.sources?.sources.count)! {
                    self.dbObject.saveSourceData(self.sources?.sources[i].id ?? "" , name: self.sources?.sources[i].name ?? "", category: self.sources?.sources[i].category ?? "" )
                      }
                self.filteredData = response
                self.sourcesCollectionView.reloadData()
            }
        }
    
            if Reachability.isConnectedToNetwork(){
               network = true
                print("Internet Available!")
            } else{
                print("Internet Connection not Available!")
            }
    }

    
        func fetchData () {
         //   let fetchRequest: NSFetchRequest<SourceDB> = SourceDB.fetchRequest()
            let fetchRequest = NSFetchRequest<SourceDB>(entityName: "SourceDB")
            do {
                let sourceModel = try context.fetch(fetchRequest)
                self.sourcesDB = sourceModel
                sourcesCollectionView.reloadData()
            } catch {}
        }


    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func configureCollectionView() {
        self.sourcesCollectionView.dataSource = self
        self.sourcesCollectionView.delegate = self
        self.sourcesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.sourcesCollectionView.register(UINib(nibName: "SourcesCell", bundle: nil), forCellWithReuseIdentifier: "SourcesCell")
    }
    
    func configureNavbarAndSearchBar () {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News by Sources"
        self.navigationController!.tabBarItem.title = "Sources"
        sourcesSearch.delegate = self
        sourcesSearch.placeholder = "Find sources"
    }
}

extension SourcesVC :
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
  
    
    //MARK: - NUMBERS OF CELLS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if network == false {
        return sourcesDB.count
        } else {
            return sources?.sources.count ?? 10
        }
    }
    
    //MARK: - ASSIGNING THE DATA
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourcesCell", for: indexPath) as! SourcesCell
        
        if network == false {
            let vc = sourcesDB[indexPath.row]
            cell.sourceTitleLabel.text = vc.name
            cell.categoryTittleLabel.text = vc.category?.capitalized
        } else {
            let vc = sources?.sources[indexPath.row]
            cell.sourceTitleLabel.text = vc?.name
            cell.categoryTittleLabel.text = vc?.category?.capitalized
        }
        
       
        
        switch cell.categoryTittleLabel.text?.lowercased() {
        case "general":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0, green: 0.6384097938, blue: 0.5209903847, alpha: 1)
        case "business":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
        case "science":
            cell.rombCell.backgroundColor = #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1)
        case "technology":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "health":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "entertainment":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "sports":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1)
        default:
            cell.rombCell.backgroundColor = .lightGray
            
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    //MARK: - ADDING BORDERS
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 7, bottom: 0, right: 7)
    }
    
    //MARK: - SETTING SIZES
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 13
        let space: CGFloat = 10
        let itemWidth = (collectionView.bounds.width) - (padding * 2) - space
        let getWidth = itemWidth/2
        
        return CGSize(width: getWidth, height: getWidth)
    }
    
    //MARK: - SENDING DATA TO THE CATEGORYVC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedCategory = sourcesDB[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        vc.sourceName = tappedCategory.name
        vc.sourceId = tappedCategory.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SourcesVC: UISearchBarDelegate {
    
    //MARK: - STARTS SEARCH WHEN TEXT IS EXISTS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty  else {
                sources?.sources = filteredData!.sources
                sourcesCollectionView.reloadData()
                return
            }
        //MARK: -  FILTERING THE ARRAY BY SOURCE.NAME
        sources?.sources = (filteredData?.sources.filter({ source -> Bool in
            (source.name?.lowercased().contains(searchText.lowercased()))!
        }))!
        sourcesCollectionView.reloadData()
    }
}
