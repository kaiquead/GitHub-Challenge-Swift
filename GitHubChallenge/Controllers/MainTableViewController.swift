//
//  MainTableViewController.swift
//  GitHubChallenge
//
//  Created by Kaique Alves on 21/03/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var github: GitHub!
    var items: [GitHub.Item] = []
    var currentPage =  1
    var isLoading = false
    var carregados = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGitHub()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func loadGitHub(){
        self.isLoading = true
        REST.loadAGitHubList(page: currentPage, onComplete: { (github, statusCode) in
            self.github = github
            self.items += self.github.items
            self.total = github.totalCount
            print("Total: \(self.total)  - Já carregados: \(self.items.count)")
            DispatchQueue.main.async {
                self.isLoading = false
                self.tableView.reloadData()
            }
            print ("Carregados!!")
            
        }) { (error) in
            self.isLoading = false
            print("Não carregou! Algo está errado")
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        loadGitHub()
        sender.endRefreshing()
        print("pullToRefresh")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GitHubTableViewCell
        
        let git = items[indexPath.row]
        cell.prepare(with: git)
        return cell
    }
    
    // MARK: Infinity Scroll
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 40 && !isLoading && items.count != total{
            currentPage+=1
            loadGitHub()
            print("Loading more Repos")
        }
        
    }
    
}
