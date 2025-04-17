//
//  ToastHelper.swift
//  BookXpert
//
//  Created by Sree Lakshman on 17/04/25.
//

import UIKit

extension UIViewController {
    /// Shows a notification‑style banner from the top.
    func showNotificationBanner(title: String?,
                                message: String,
                                icon: UIImage? = nil,
                                duration: TimeInterval = 3.0) {
        // 1. Create container
        let bannerHeight: CGFloat = 80
        let banner = UIView()
        banner.backgroundColor = .systemGray6
        banner.layer.cornerRadius = 12
        banner.layer.masksToBounds = true
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        // 2. Add blur behind (optional)
        let blur = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        banner.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: banner.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: banner.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: banner.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: banner.trailingAnchor),
        ])
        
        // 3. Icon view
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        banner.addSubview(imageView)
        
        // 4. Title & message labels
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .label
        titleLabel.text = title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .secondaryLabel
        messageLabel.text = message
        messageLabel.numberOfLines = 2
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        banner.addSubview(stack)
        
        // 5. Add to key window
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        window.addSubview(banner)
        
        // 6. Layout constraints
        let topConstraint = banner.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: -bannerHeight)
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 16),
            banner.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -16),
            topConstraint,
            banner.heightAnchor.constraint(equalToConstant: bannerHeight),
            
            imageView.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: banner.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            
            stack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -12),
            stack.centerYAnchor.constraint(equalTo: banner.centerYAnchor),
        ])
        
        window.layoutIfNeeded()
        
        // 7. Animate down
        topConstraint.constant = 8
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            window.layoutIfNeeded()
        } completion: { _ in
            // 8. Hide after duration
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseIn) {
                topConstraint.constant = -bannerHeight
                window.layoutIfNeeded()
            } completion: { _ in
                banner.removeFromSuperview()
            }
        }
    }
}
