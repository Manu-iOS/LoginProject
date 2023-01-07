//
//  ViewController.swift
//  LoginProject
//
//  Created by 노민우 on 2023/01/07.
//

import UIKit

class ViewController: UIViewController {
    
    // 메모리에 올려놈
    let emailTextFieldView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        /**
         autoresizingMask는 superview가 변함에 따라 subview의 크기를 어떻게 할것인가이기 때문에, 이와 동일한 기능을 하는 autolayout에서 같이 사용된다면
         충돌이 날 수 있는것 > 충돌 방지를 위해 Auturesizing을 사용하지 않는것으로 명시적 선언 **/
        view.translatesAutoresizingMaskIntoConstraints = false
        // Storybode에서는 autolayout을 사용하면 자동으로 false로 설정된다.
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        emailTextFieldView.backgroundColor = UIColor.darkGray
        
        // view에 추가
        view.addSubview(emailTextFieldView)
        
        // 오토레리아웃을 지정
        // constraint(제약) : 오토레이아웃
        // equalTo : 어디를(view.leadingAnchor 기본 view의 왼쪽) 기준으로 맞출 것인지 지정
        // isActive = true : 활성화
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        // 오른쪽
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        // 위
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        // 높이는 기준이 없다
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
}

