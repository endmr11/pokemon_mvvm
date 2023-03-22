//
//  PokemonTableViewCell.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import UIKit
import Kingfisher

private enum PokemonTableViewCellConstant {
    static let viewColor = Color.pokemonCellBackgrounColor
    static let borderColor = Color.black
}

class PokemonTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = PokemonTableViewCellConstant.viewColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = PokemonTableViewCellConstant.borderColor.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25)
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
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
    }
}

extension PokemonTableViewCell {
    private func configureCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:self.topAnchor,constant: 8),
            containerView.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -8),
            containerView.leftAnchor.constraint(equalTo:self.leftAnchor,constant: 8),
            containerView.rightAnchor.constraint(equalTo:self.rightAnchor,constant: -8),

            posterImageView.topAnchor.constraint(equalTo:self.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -8),
            posterImageView.leftAnchor.constraint(equalTo:self.leftAnchor),
            posterImageView.widthAnchor.constraint(equalTo:self.widthAnchor,multiplier: 0.35),

            titleLabel.topAnchor.constraint(equalTo:posterImageView.topAnchor,constant: 10),
            titleLabel.leftAnchor.constraint(equalTo:posterImageView.rightAnchor,constant: 8),
            titleLabel.rightAnchor.constraint(equalTo:self.rightAnchor,constant: -8),
            titleLabel.heightAnchor.constraint(equalTo:self.heightAnchor,multiplier: 0.4),
        ])
    }
}

extension PokemonTableViewCell {
    func setCell(model: Pokemon) {
        posterImageView.kf.setImage(with: URL(string: model.imgUrl ?? ""))
        titleLabel.text = model.name?.capitalized
    }
}
