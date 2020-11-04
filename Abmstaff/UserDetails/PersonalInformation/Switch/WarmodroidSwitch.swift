//
//  WarmodroidSwitch.swift
//  Abmstaff
//
//  Created by Hovo on 11/3/20.
//

import Foundation
import UIKit

protocol WarmodroidSwitchDelegate {
    func didTapSwitch(swithcher: WarmodroidSwitch, isON: Bool)
}


class WarmodroidSwitch: UIView {
    
    private var containerView: UIView!
    private var elipticalView: UIView!
    private var thumb: UIView!
    private var thumbTrailingConstraint: NSLayoutConstraint!
    var delegate: WarmodroidSwitchDelegate?
    var isOn = false
    var onThumbColor = UIColor(red: 246/255, green: 0, blue: 101/255, alpha: 1)
    var offThumbColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    var onBackgroundColor = UIColor(red: 246/255, green: 0, blue: 101/255, alpha: 0.32)
    var offBackgroungColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    private func commonInit() {
        let padding = frame.size.height*0.15
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        elipticalView = UIView()
        
        elipticalView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(elipticalView)
        elipticalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        elipticalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        elipticalView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        elipticalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        elipticalView.layer.cornerRadius = (frame.size.height - padding*2)/2
        
        thumb = UIView()
        
        thumb.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumb)
        thumbTrailingConstraint = thumb.trailingAnchor.constraint(equalTo: trailingAnchor)
        thumbTrailingConstraint.isActive = true
        setState()
        thumb.heightAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: frame.size.height).isActive = true
        thumb.layer.cornerRadius = frame.size.height/2
        let thumbTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnThumb))
        self.addGestureRecognizer(thumbTapGesture)
    }
    
    @objc private func didTapOnThumb() {
        isOn = !isOn
        setState()
        delegate?.didTapSwitch(swithcher: self, isON: isOn)
       
    }

    func setState() {
        if isOn {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = 0
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = onBackgroundColor
            thumb.backgroundColor = onThumbColor
        } else {
            UIView.animate(withDuration: 0.2,delay: 0.0, options: .curveEaseInOut, animations: {
                self.thumbTrailingConstraint.constant = -self.frame.size.width/2
                self.layoutIfNeeded()
            }, completion: nil)
            elipticalView.backgroundColor = offBackgroungColor
            thumb.backgroundColor = offThumbColor
        }
    }
}
