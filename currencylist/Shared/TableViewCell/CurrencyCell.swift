//
//  CurrencyCell.swift
//  currencylist
//
//  Created by Andrey Oshev on 11/04/2018.
//  Copyright © 2018 Andrey Oshev. All rights reserved.
//

import UIKit
import SnapKit

class CurrencyCell: UITableViewCell {
    
    private lazy var amountLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        
        amountLabel.textColor = UIColor.black
        contentView.addSubview(amountLabel)
        
        setNeedsLayout()
        layoutIfNeeded()
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        amountLabel.snp.updateConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        super.updateConstraints()
    }
    
    public func configure(with currency: Currency) {
        textLabel?.text = currency.name
        detailTextLabel?.text = "\(currency.volume)"
        amountLabel.text = String(format: "%.2f", currency.amount)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
}
