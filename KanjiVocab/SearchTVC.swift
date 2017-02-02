//
//  SearchTVC.swift
//  KanjiVocab
//
//  Created by Jonathan Clarke on 31/01/2017.
//  Copyright © 2017 Jonathan Clarke. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewController, UISearchResultsUpdating {

    var filteredTriplets : [Triplet] = []
    
    static func loadVC( sb : UIStoryboard, nc : UINavigationController )
    {
        if let vc = sb.instantiateViewController(withIdentifier: "SearchTVC") as? SearchTVC {
            nc.pushViewController( vc, animated: true)
        }
        
    }
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.clickAdd) )

        let cellID = TripleCell.getReuseIdentifier()
        let nib = UINib(nibName: cellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickAdd()
    {
        EditVC.loadVC( sb: self.storyboard!, nc: self.navigationController! )
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredTriplets.count
        }
        return Vocab.sharedInstance.triplets.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripleCell.getReuseIdentifier(), for: indexPath) as! TripleCell
        var triplet = Vocab.sharedInstance.triplets.reversed()[ indexPath.row ]
        if searchController.isActive && searchController.searchBar.text != "" {
            triplet = filteredTriplets[indexPath.row]
        }
        cell.display(triplet: triplet)
        return cell
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        filterForSearchText(searchText: searchController.searchBar.text!)
    }

    func filterForSearchText(searchText: String, scope: String = "All") {
        filteredTriplets = Vocab.sharedInstance.triplets.reversed().filter { triplet in return triplet.matches( searchText: searchText )
        }
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
