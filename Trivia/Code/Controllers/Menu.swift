import UIKit

protocol MenuControllerDelegate
{
    func didSelectMenuItem(named: String)
}

class MenuController: UITableViewController
{
    public var delegate: MenuControllerDelegate?
    private let menuItems: [String]
    
    init(with menuItems: [String])
    {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.backgroundColor =  UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        
        view.backgroundColor =  UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Kohinoor Telugu" ,size:24)
        cell.backgroundColor =  UIColor(red: 187/255.0, green: 147/255.0, blue: 221/255.0, alpha: 1.0)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItems.count
    }
}
