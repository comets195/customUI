//
//  SharedListDateStackView.swift
//  cashfeed
//
//  Created by DongJin Lee on 2020/04/01.
//  Copyright © 2020 DongJin Lee. All rights reserved.
//

import Foundation

protocol ShareListDateStackViewDelegate: class {
    func selected(date: Date)
}

class SharedListDateStackView: UIView, NibLoadable {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    private var buttons = [UIButton]()
    private var dataSource = [Date]()
    private var toDayIndex = 0
    
    weak var delegate: ShareListDateStackViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        if toDayIndex > 3 {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - bounds.width, y: 0), animated: false)
        }
    }
    
    func setDataSource(date: [Date], toDayIndex: Int) {
        let dateViewWidth: CGFloat = 68.0
        self.dataSource = date
        
        for (index, date) in dataSource.enumerated() {
            let backGroundView = UIView()
            backGroundView.backgroundColor = .white
            backGroundView.translatesAutoresizingMaskIntoConstraints = false
            backGroundView.widthAnchor.constraint(equalToConstant: dateViewWidth).isActive = true
            
            let dateLabel = UIButton()
            let attributedStringNormal = NSAttributedString(string: convertDate(date: date),
                                                      attributes: [.font : UIFontUtil.spoqa(size: 18, type: .Regular),
                                                                   .foregroundColor: UIColor.gray360])
            dateLabel.setAttributedTitle(attributedStringNormal, for: .normal)
            
            let attributedStringSelected = NSAttributedString(string: convertDate(date: date),
                                                              attributes: [.font : UIFontUtil.spoqa(size: 18, type: .Regular),
                                                                           .foregroundColor: UIColor.black])
            dateLabel.setAttributedTitle(attributedStringSelected, for: .selected)
            
            backGroundView.addSubview(dateLabel)
            
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 20.0).isActive = true
            dateLabel.topAnchor.constraint(equalTo: backGroundView.topAnchor).isActive = true
            dateLabel.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor).isActive = true
            dateLabel.tag = index
            dateLabel.addTarget(self, action: #selector(tapDate(_:)), for: .touchUpInside)
            
            buttons.append(dateLabel)
            stackView.addArrangedSubview(backGroundView)
        }
        
        let spacor = UIView()
        spacor.translatesAutoresizingMaskIntoConstraints = false
        spacor.backgroundColor = .white
        spacor.widthAnchor.constraint(equalToConstant: 20).isActive = true
        stackView.addArrangedSubview(spacor)
        
        buttons[toDayIndex].isSelected = true
        self.toDayIndex = toDayIndex
    }
    
    private func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        
        return dateFormatter.string(from: date)
    }
    
    @objc private func tapDate(_ sender: UIButton) {
        guard !sender.isSelected else { return }
        let date = dataSource[sender.tag]
        
        buttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        self.delegate?.selected(date: date)
    }
}
