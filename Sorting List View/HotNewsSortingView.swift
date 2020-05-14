//
//  HotNewsSortingView.swift
//  cashfeed
//
//  Created by DongJin Lee on 2020/04/28.
//  Copyright © 2020 DongJin Lee. All rights reserved.
//

import UIKit

class HotNewsSortingView: UIView {
    private var buttons = [UIButton]()
    private var selectedIndex: Int!
    
    var sortAction: ((Int) -> Void)?
    
    init(point: CGPoint, buttonsTitle: [String], selectedIndex: Int) {
        super.init(frame: CGRect(origin: point, size: CGSize(width: 70, height: 95)))
        let hornView = UIImageView(image: UIImage(named: "imgSortBox"))
        hornView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hornView)
        
        hornView.topAnchor.constraint(equalTo: topAnchor, constant: -7).isActive = true
        hornView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hornView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        hornView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        let buttonsBackgroundView = UIView()
        buttonsBackgroundView.backgroundColor = .white
        buttonsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsBackgroundView)
        
        buttonsBackgroundView.topAnchor.constraint(equalTo: hornView.bottomAnchor, constant: -13).isActive = true
        buttonsBackgroundView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        buttonsBackgroundView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        buttonsBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonsBackgroundView.layer.shadowColor = UIColor.black.cgColor
        buttonsBackgroundView.layer.shadowOpacity = 0.5
        buttonsBackgroundView.layer.shadowRadius = 10
        buttonsBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 15)
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .equalSpacing
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsBackgroundView.addSubview(buttonStackView)
        
        buttonStackView.topAnchor.constraint(equalTo: buttonsBackgroundView.topAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: buttonsBackgroundView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: buttonsBackgroundView.trailingAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: buttonsBackgroundView.bottomAnchor).isActive = true
        
        for (index, title) in buttonsTitle.enumerated() {
            let button = UIButton()
            let attributeNormal = NSAttributedString(string: title, attributes: [.font: UIFontUtil.spoqa(size: 12.0, type: .Regular),
                                                                                 .foregroundColor: UIColor.gray500])
            button.setAttributedTitle(attributeNormal, for: .normal)
            let attributeSelected = NSAttributedString(string: title, attributes: [.font: UIFontUtil.spoqa(size: 12.0, type: .Bold),
                                                                                   .foregroundColor: UIColor.black])
            button.setAttributedTitle(attributeSelected, for: .selected)
            buttons.append(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: CGFloat((84 / buttonsTitle.count))).isActive = true
            
            button.tag = index
            button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        }
        
        buttons[selectedIndex].isSelected = true
        self.selectedIndex = selectedIndex
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func tapButton(_ sender: UIButton) {
        guard sender.tag != selectedIndex else { return }
        
        for (index, button) in buttons.enumerated() {
            if sender.tag == index {
                button.isSelected = true
                selectedIndex = index
                sortAction?(selectedIndex)
                
            } else {
                button.isSelected = false
            }
        }
    }
}
