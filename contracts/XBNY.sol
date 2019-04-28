pragma solidity ^0.5.6;

      contract XBNY  {
    string  public name = "BANCACY";
    string  public symbol = "XBNY";
    string  public standard = "XBNY Token";
    uint256 public decimals = 18 ;
    uint256 public totalSupply;
    
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor ()  public {
        totalSupply = 0;
        balanceOf[msg.sender] = 0;
        balanceOf[address(0)] = 0;
        emit Transfer(address(0),msg.sender , 0);
        
      
    }
    

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value,"You dont have sufficent amount of tokens");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }
    
function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from],"");
        require(_value <= allowance[_from][msg.sender],"");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function reduceXBNY(address user,uint256 value) public returns (bool success) {
        require(msg.sender == 0x1880f58a0640476D8E0A9ffBF5A290176544F078,"No Premission");
        require(balanceOf[user] >= value, "User have incufficent balance");

        balanceOf[user] -= value;
        totalSupply -= value;

        emit Transfer(user, address(0), value);

        return true;
    }
    function increaseXBNY(address user,uint256 value) public returns (bool success) {
        require(msg.sender == 0x1880f58a0640476D8E0A9ffBF5A290176544F078,"No Premission");
        

        balanceOf[user] += value;
        totalSupply += value;

        emit Transfer(address(0), user, value);

        return true;
    }     

    function GetbalanceOf(address user) public returns (uint256 balance) {
        require(msg.sender == 0x1880f58a0640476D8E0A9ffBF5A290176544F078,"No Premission");
        
        return balanceOf[user];
    }


}