import UIKit
import SideMenu

class GameViewController: UIViewController, MenuControllerDelegate
{
    static var counter: Int?
    static var progressCount: Float = 0.1
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var timer: UILabel!
    var timerObject = Timer()
    var submitTime = 10
    @IBOutlet weak var progress: UIProgressView!
    
    var quest: QnA?
    private var menu:  SideMenuNavigationController?
    var rootController = MenuController(with: ["Home", "Leaderboard", "Match History", "Logout"])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
       
            newQuestion()
    }
    
    
    @IBAction func ans1BtnPressed(_ sender: Any)
    {
        disableButtons()
        
        RequestHandler.checkAnswer(answer: (btn1.titleLabel?.text)!, timeTaken: submitTime)
        
        if(quest!.counter < 9)
        {
            newQuestion()
        }
        else
        {
            GameViewController.counter = 0
            GameViewController.progressCount = 0.1
            performSegue(withIdentifier: "Game2End", sender: self)
        }
    }
    
    @IBAction func ans2BtnPressed(_ sender: Any)
    {
        disableButtons()
        
        RequestHandler.checkAnswer(answer: (btn2.titleLabel?.text)!, timeTaken: submitTime)
        
        if(quest!.counter < 9)
        {
            newQuestion()
        }
        else
        {
            GameViewController.counter = 0
            GameViewController.progressCount = 0.1
            performSegue(withIdentifier: "Game2End", sender: self)
        }
    }
    
    @IBAction func ans3BtnPressed(_ sender: Any)
    {
        disableButtons()
        
        RequestHandler.checkAnswer(answer: (btn3.titleLabel?.text)!, timeTaken: submitTime)

        if(quest!.counter < 9)
        {
            newQuestion()
        }
        else
        {
            GameViewController.counter = 0
            GameViewController.progressCount = 0.1
            performSegue(withIdentifier: "Game2End", sender: self)
        }
    }
    
    @IBAction func ans4BtnPressed(_ sender: Any)
    {
        disableButtons()
        
        RequestHandler.checkAnswer(answer: (btn4.titleLabel?.text)!, timeTaken: submitTime)
        
        if(quest!.counter < 9)
        {
            newQuestion()
        }
        else
        {
            GameViewController.counter = 0
            GameViewController.progressCount = 0.1
            performSegue(withIdentifier: "Game2End", sender: self)
        }
    }
    
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    
    func newQuestion()
    {
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
    
        submitTime = 10
        timerObject.invalidate()
        timerObject = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(updateTimer),userInfo:nil, repeats:true )
        quest = RequestHandler.getQuestion()
        question.text = quest?.question
        btn1.setTitle(quest!.answers[0], for: .normal)
        btn2.setTitle(quest!.answers[1], for: .normal)
        btn3.setTitle(quest!.answers[2], for: .normal)
        btn4.setTitle(quest!.answers[3], for: .normal)
        progress.progress = Float(quest!.counter + 1) * 0.1
    }
    
    @objc func updateTimer()
    {
        if(submitTime == 0)
        {
            timerObject.invalidate()
        }
        
        timer.text = String(submitTime)
        submitTime -= 1
    }
    
    func disableButtons()
    {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
    }
    
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "Game2Home", sender: Any?.self)
            }
            else if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "Game2Leader", sender: Any?.self)
            }
            else if(named == "Logout")
            {
                RequestHandler.logout()
                self.performSegue(withIdentifier: "Game2Home", sender: Any?.self)
            }
            else if(named == "Match History")
            {
                self.performSegue(withIdentifier: "Game2History", sender: Any?.self)
            }
        })
    }
}
