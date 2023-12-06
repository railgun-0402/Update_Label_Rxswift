//
//  ViewController.swift
//  update_rx
//
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストフィールドの入力を監視し、変更があれば変更内容を表示ラベルに反映
        inputTextField.rx.text
            .map{ $0 ?? ""}
            .bind(to: displayLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 更新ボタンがタップされた時の処理
        updateButton.rx.tap
            .subscribe(onNext: { [weak self] in
                // ボタンが押されたら、テキストフィールドの内容をラベルに反映
                self?.displayLabel.text = self?.inputTextField.text
            })
            .disposed(by: disposeBag)
    }
}

