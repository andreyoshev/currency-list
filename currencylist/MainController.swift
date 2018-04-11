//
//  MainController.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit
import SnapKit

class MainController: ViewController {

    private lazy var tableView = UITableView()
    private lazy var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    private lazy var timer = Timer()
    
    private var service = ApiService()
    private var currencies = [Currency]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
        setupTimer()
    }
    
    override func setupView() {
        super.setupView()
        self.title = "Stocks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getData))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)
        
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.backgroundColor = UIColor.clear
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        relayout()
    }
    
    @objc private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(getData), userInfo: nil, repeats: true)
    }
    
    override func updateViewConstraints() {
        tableView.snp.updateConstraints {
            $0.edges.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func getData() {
        if (spinner.isAnimating) { return }
        
        spinner.startAnimating()
        service.getStocks { (result, error) in
            if (error == nil) {
                self.spinner.stopAnimating()
                if let result = result as? [Currency] {
                    self.currencies = result
                    self.tableView.reloadData()
                }
            }
            else {
                self.spinner.stopAnimating()
            }
        }
    }
}

    // MARK: - UITableViewDataSource

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencyCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier) as? CurrencyCell else {
                return CurrencyCell(style: .subtitle, reuseIdentifier: CurrencyCell.identifier)
            }
            return cell
        }()
        
        let currency = currencies[indexPath.row]
        cell.configure(with: currency)
        
        return cell
    }
}
