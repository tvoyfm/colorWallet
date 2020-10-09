import UIKit

@IBDesignable class ViewController: UIViewController {
    
    @IBOutlet weak var button: ChangeButton!
    @IBOutlet weak var clockView: ClockView!
    
    var segmControl = UISegmentedControl()
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        createTaskSegmentedControl()

    }

    @IBAction func buttonTapped(_ sender: Any) {
        button.buttonColor = .random()
    }
    
    
    func createTaskSegmentedControl() {
        let items = ["1️⃣", "2️⃣", "3️⃣"]
        segmControl = UISegmentedControl(items: items)
        segmControl.addTarget(self, action: #selector(taskDidChange(_:)), for: .valueChanged)
        segmControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmControl)

        NSLayoutConstraint.activate([
            segmControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            segmControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35)

        ])

    // Заголовок
        let segmLabel = UILabel()
        segmLabel.text = "Выбери задание"
        segmLabel.textColor = UIColor.black
        segmLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmLabel)

        NSLayoutConstraint.activate([
            segmLabel.bottomAnchor.constraint(equalTo: segmControl.topAnchor, constant: -15),
            segmLabel.centerXAnchor.constraint(equalTo: segmControl.centerXAnchor)
        ])

    }

    @objc func taskDidChange(_ segmControl: UISegmentedControl){
        switch segmControl.selectedSegmentIndex{
        case 0: // Задание 1
            print("1")
        case 1: // Задание 2
            print("2")
        case 2: // Задание 3
            print("3")
        default:
            print("def")
        }
    }
}
