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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .right
        contentView.addSubview(titleLabel)
    }
    
    private func setupSubtitleLabel(){
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .right
        contentView.addSubview(subtitleLabel)
        
    }
    
    private func setupiconImageView(){
        let image = UIImage(systemName: "house")
        iconImageView.image = image
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 8
        iconImageView.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
                   iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                   iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                   iconImageView.widthAnchor.constraint(equalToConstant: 40),
                   iconImageView.heightAnchor.constraint(equalToConstant: 40)
                   
                   ])
        contentView.addSubview(iconImageView)
    }
    
}
