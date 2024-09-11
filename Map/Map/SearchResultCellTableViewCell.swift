//
//  SearchResultCellTableViewCell.swift
//  Map
//
//  Created by Mahsa on 9/11/24.
//

import UIKit

class SearchResultCellTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let iconImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        setupTitleLabel()
        setupSubtitleLabel()
        setupiconImageView()
    }
    
    private func setupTitleLabel(){
        
    }
    
    private func setupSubtitleLabel(){
        
    }
    
    private func setupiconImageView(){
        
    }
    
}
