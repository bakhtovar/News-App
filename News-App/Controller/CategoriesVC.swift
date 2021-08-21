//
//  ViewController.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit

class CategoriesVC: UIViewController {
    
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: - INSTANCE OF MODEL
    var category = CategoriesBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavbarAndSearchbar()
    }
}

extension CategoriesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // MARK:- TITTLE
    func configureNavbarAndSearchbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "News by Category"
        self.navigationController?.tabBarItem.title = "Categories"
        searchBar.delegate = self
        searchBar.placeholder = "Search for news"
        hideKeyboard()
    }
    
    func configureCollectionView(){
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        self.myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        //MARK: - REGISTER IS NEDEED FOR CELL(ITEM)
        self.myCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.cat.count
    }
    //MARK: - DRAW AND ASSING PROPS
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let categoryName = category.cat[indexPath.row]
        cell.backgroundColor = categoryName.background
        cell.categoryLabel.text = categoryName.nameLabel
        cell.layer.cornerRadius = 10
        return cell
    }
    
    //MARK: - UP/DOWN/LEFT/RIGHT - FOR EACH ITEM
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 7, bottom: 0, right: 7)
    }
    
    //MARK: - SIZE OF EACH ITEM IN COLLECTIONVIEW
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 13
        let space: CGFloat = 10
        let itemWidth = (collectionView.bounds.width) - (padding * 2) - space
        let getWidth = itemWidth/2
        return CGSize(width: getWidth, height: getWidth)
    }
    //MARK: - NAVIGATION ON TAPPING
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedCategory = category.cat[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        
        //MARK: - SENDING TO CATEGORYVC
        
        vc.titleName = tappedCategory.nameLabel
        vc.urlString = tappedCategory.url
        vc.labelText = searchBar.text
        vc.buttonId = tappedCategory.catId
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoriesVC: UISearchBarDelegate {
    
    func hideKeyboard() {
        //MARK: - HIDES KEYBOARD
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - ACTION IN SEARCHBAR
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let searchText = searchBar.text!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        
        vc.labelText = searchText
        self.navigationController?.pushViewController(vc, animated: true)
        
        //MARK: - CLEAR THE SEARCHBAR.TEXT
        if searchBar.text != nil {
            searchBar.text = ""
        }
    }
    
    //MARK: - SEARCHBAR TEXT
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
    
}
