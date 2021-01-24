import SideMenu
import UIKit

class LoginViewController: UIViewController, MenuControllerDelegate
{
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var reqResponse: GenericResponse?
    private var menu:  SideMenuNavigationController?
    var rootController = MenuController(with: ["Home", "Leaderboard"])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: rootController)
        
        rootController.delegate = self
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any)
    {
        if(username != nil && password != nil && username.text != "" && password.text != "")
        {
            reqResponse = RequestHandler.login(username: username.text!, password: password.text!)
            
            if(reqResponse!.error == true)
            {
                present(RequestHandler.alert(title: "ERROR", message: reqResponse!.message!), animated: true, completion: nil)
            }
            else
            {
                performSegue(withIdentifier: "Login2Home", sender: self)
            }
        }
        else
        {
            present(RequestHandler.alert(title: "MISSING INFO", message: "Please fill in all fields..."), animated: true, completion: nil)
        }
    }
    
    func didSelectMenuItem(named: String)
    {
        menu?.dismiss(animated: true, completion:
        {
            if(named == "Home")
            {
                self.performSegue(withIdentifier: "Login2Home", sender: Any?.self)
            }
            else if(named == "Leaderboard")
            {
                self.performSegue(withIdentifier: "Login2Leader", sender: Any?.self)
            }
        })
       
    }
    @IBAction func menuBtnPressed(_ sender: Any)
    {
        present(menu!, animated:true)
    }
    
    @IBAction func registerBtnPressed(_ sender: Any)
    {
        if(username != nil && password != nil && username.text != "" && password.text != "")
        {
            reqResponse = RequestHandler.register(username: username.text!, password: password.text!)
            
            if(reqResponse!.error == true)
            {
                present(RequestHandler.alert(title: "ERROR", message: reqResponse!.message!), animated: true, completion: nil)
            }
            else
            {
                present(RequestHandler.alert(title:"SUCCESS", message:"Account created!"), animated:true)
            }
        }
        else
        {
            present(RequestHandler.alert(title: "MISSING INFO", message: "Please fill in all fields..."), animated: true)
        }
    }
}
