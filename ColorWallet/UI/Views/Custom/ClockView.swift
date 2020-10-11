import UIKit

@IBDesignable
class ClockView: UIView {
    var isSetuped = false

    // Settings
    // --- Markers
    @IBInspectable var markerSize: CGFloat = 3
    @IBInspectable var markerLength: CGFloat = 12
    @IBInspectable var markerColor: UIColor = UIColor.blue
    // --- Hours
    @IBInspectable var hourLineOffset: CGFloat = 45
    @IBInspectable var hourLineSize: CGFloat = 4
    @IBInspectable var hourLineColor: UIColor = UIColor.green
    // --- Minutes
    @IBInspectable var minLineOffset: CGFloat = 25
    @IBInspectable var minLineSize: CGFloat = 5
    @IBInspectable var minLineColor: UIColor = UIColor.blue
    // --- Seconds
    @IBInspectable var secLineOffset: CGFloat = 15
    @IBInspectable var secLineSize: CGFloat = 1
    @IBInspectable var secLineColor: UIColor = UIColor.red
    // --- Time
    @IBInspectable var hours:   CGFloat = 7
    @IBInspectable var minutes: CGFloat = 35
    @IBInspectable var seconds: CGFloat = 59
    // --- Other
    @IBInspectable var roundedViewColor: UIColor = UIColor.yellow
    // ------------------------------------------------------
    
    // Objects
    // --- Markers
    private let topMarker       = UIView()
    private let leftMarker      = UIView()
    private let rightMarker     = UIView()
    private let bottomMarker    = UIView()
    // --- Lines
    private let hourLine    = UIView()
    private let minLine     = UIView()
    private let secLine     = UIView()
    // --- Other
    private let roundedView = UIView()
    private var timer = Timer()
    // ------------------------------------------------------
    
    // Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = frame.size.width
        let h = frame.size.height
        
        layer.cornerRadius = frame.size.width / 2
        
        if isSetuped { return }
        isSetuped = true
        
        for v in [topMarker, leftMarker, rightMarker, bottomMarker]{
            v.backgroundColor = markerColor
        }

        roundedView.backgroundColor = roundedViewColor
        roundedView.frame = CGRect(x: w / 2 - 6, y: h / 2 - 6, width: 12, height: 12)
        roundedView.layer.cornerRadius = 6
        
        // markers setup
        topMarker.frame = CGRect(x: w / 2 - markerSize / 2, y: 0, width: markerSize, height: markerLength)
        bottomMarker.frame = CGRect(x: w / 2 - markerSize / 2, y: h - markerLength, width: markerSize, height: markerLength)
        leftMarker.frame = CGRect(x: 0, y: h / 2 - markerSize / 2, width: markerLength, height: markerSize)
        rightMarker.frame = CGRect(x: w - markerLength, y: h / 2 - markerSize / 2, width: markerLength, height: markerSize)
        
        // hour line setup
        hourLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        hourLine.frame = CGRect(x: w / 2 - hourLineSize / 2, y: hourLineOffset, width: hourLineSize, height: h/2 - hourLineOffset)
        hourLine.backgroundColor = hourLineColor
        
        // min line setup
        minLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minLine.frame = CGRect(x: w / 2 - minLineSize / 2, y: minLineOffset, width: minLineSize, height: h/2 - minLineOffset)
        minLine.backgroundColor = minLineColor
        
        // sec line setup
        secLine.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secLine.frame = CGRect(x: w / 2 - secLineSize / 2, y: secLineOffset, width: secLineSize, height: h/2 - secLineOffset)
        secLine.backgroundColor = secLineColor
        
        for v in [topMarker, leftMarker, rightMarker, bottomMarker, hourLine, minLine, secLine, roundedView]{
            addSubview(v)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateHours), userInfo: nil, repeats: true)
        
        // move lines
        let angleH = CGFloat.pi * 2 * (self.hours / CGFloat(12))
        self.hourLine.transform = CGAffineTransform(rotationAngle: angleH)
        
        let angleM = CGFloat.pi * 2 * (self.minutes / CGFloat(60))
        self.minLine.transform = CGAffineTransform(rotationAngle: angleM)
        
        let angleS = CGFloat.pi * 2 * (self.seconds / CGFloat(60))
        self.secLine.transform = CGAffineTransform(rotationAngle: angleS)
}
    
    @objc func updateHours(){
        let currentTime = Date()
        let formatter = DateFormatter()
        
        UIView.animate(withDuration: 1.1, animations: {
            // change time
            formatter.dateFormat = ("HH")
            let hour = formatter.string(from: currentTime)
            self.hours = CGFloat(truncating: NumberFormatter().number(from: hour) ?? 0)
            
            formatter.dateFormat = ("mm")
            let min = formatter.string(from: currentTime)
            self.minutes = CGFloat(truncating: NumberFormatter().number(from: min) ?? 0)
            
            formatter.dateFormat = ("ss")
            let sec = formatter.string(from: currentTime)
            self.seconds = CGFloat(truncating: NumberFormatter().number(from: sec) ?? 0)
            
            // move lines
            let angleH = CGFloat.pi * 2 * (self.hours / CGFloat(12))
            self.hourLine.transform = CGAffineTransform(rotationAngle: angleH)
            
            let angleM = CGFloat.pi * 2 * (self.minutes / CGFloat(60))
            self.minLine.transform = CGAffineTransform(rotationAngle: angleM)
            
            let angleS = CGFloat.pi * 2 * (self.seconds / CGFloat(60))
            self.secLine.transform = CGAffineTransform(rotationAngle: angleS)
            
            self.randomColor()
        })
    }
    
    func randomColor() {
        markerColor = .random()
        minLineColor = .random()
        secLineColor = .random()
        hourLineColor = .random()
        backgroundColor = .random()
        roundedViewColor = .random()
    }
}
