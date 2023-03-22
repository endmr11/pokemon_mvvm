//
//  UIViewController+Extension.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import UIKit

fileprivate var containerView: UIView!

//MARK: - Dialog Components
extension UIViewController {
    func showToast(title:String ,text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
}

//MARK: - Loading Components
extension UIViewController {
    func showLoadingView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Color.appBase.withAlphaComponent(0.7)
        containerView.alpha = 0
        self.view.addSubview(containerView)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        containerView.addSubview(activityIndicator)
        UIView.animate(withDuration: 0.5) {
            containerView.alpha = 1
            containerView.layer.masksToBounds = true
            containerView.clipsToBounds = true
            containerView.layer.cornerRadius = 30
        }
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            containerView.widthAnchor.constraint(equalToConstant: 150),
            activityIndicator.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo:view.centerXAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}

//MARK: - Router Controllers
extension UIViewController {
    func openView(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey:kCATransition)
        navigationController?.popViewController(animated: false)
    }
}
