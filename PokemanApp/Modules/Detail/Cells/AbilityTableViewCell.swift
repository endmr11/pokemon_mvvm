//
//  AbilityTableViewCell.swift
//  PokemanApp
//
//  Created by Eren Demir on 21.03.2023.
//

import UIKit
private enum AbilityTableViewCellConstant {
    static let viewColor = Color.abilityCellBackgrounColor
    static let borderColor = Color.gray
    static let cellTextColor = Color.abilityCellTextColor
}

class AbilityTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AbilityTableViewCellConstant.viewColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = AbilityTableViewCellConstant.borderColor.withAlphaComponent(0.3).cgColor
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AbilityTableViewCellConstant.cellTextColor
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}


extension AbilityTableViewCell {
    private func prepareCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:self.topAnchor,constant: 8),
            containerView.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -8),
            containerView.leftAnchor.constraint(equalTo:self.leftAnchor,constant: 8),
            containerView.rightAnchor.constraint(equalTo:self.rightAnchor,constant: -8),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

extension AbilityTableViewCell {
    func setCell(model: Ability?) {
        titleLabel.text = model?.name.capitalized
    }
}
