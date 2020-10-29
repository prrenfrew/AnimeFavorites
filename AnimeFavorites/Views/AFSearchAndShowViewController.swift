//
//  AFSearchAndShowViewController.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import UIKit

class AFSearchAndShowViewController: UIViewController {
  
  private var animeTableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()
  
  var viewModel: SearchAndShowViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableView()
    self.setupSearch()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.viewModel.retrieveObjects { [weak self] in
      self?.animeTableView.reloadData()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationItem.searchController?.isActive = false
  }
  
  private func setupTableView() {
    self.view.addSubview(self.animeTableView)
    setupTableViewContraints()
    setupTableViewDelegates()
    self.registerCells()
  }
  
  private func setupSearch() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = self.viewModel.shouldObscureWhileSearching()
    searchController.searchBar.placeholder = self.viewModel.searchPlaceholder()
    self.navigationItem.searchController = searchController
    self.definesPresentationContext = true
  }
  
  private func setupTableViewContraints() {
    self.animeTableView.leadingAnchor.setupHorizontalConstraint(to: self.view.leadingAnchor)
    self.animeTableView.trailingAnchor.setupHorizontalConstraint(to: self.view.trailingAnchor)
    self.animeTableView.topAnchor.setupVerticalConstraint(to: self.view.topAnchor)
    self.animeTableView.bottomAnchor.setupVerticalConstraint(to: self.view.bottomAnchor)
  }
  
  private func setupTableViewDelegates() {
    self.animeTableView.dataSource = self
    self.animeTableView.delegate = self
  }
  
  private func registerCells() {
    let nib = UINib(nibName: "AnimeTableViewCell", bundle: nil)
    self.animeTableView.register(nib, forCellReuseIdentifier: "AnimeTableViewCell")
  }
}

extension AFSearchAndShowViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.numberOfObjectsToShow()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
    cell.configure(with: self.viewModel.detailViewModel(for: indexPath.row))
    return cell
  }
}

extension AFSearchAndShowViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.viewModel.toggleFavorite(at: indexPath.row) { [weak self] in
      DispatchQueue.main.async {
        self?.animeTableView.reloadData()
      }
    }
  }
}

extension AFSearchAndShowViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    self.viewModel.search(with: searchText) { [weak self] in
      DispatchQueue.main.async {
        self?.animeTableView.reloadData()
      }
    }
  }
}
