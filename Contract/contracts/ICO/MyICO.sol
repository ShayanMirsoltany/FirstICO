// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract MyICO {

    address public  _admin;
    IERC20 private _token;
    uint private _tokenPrice = 10**15 wei;
    uint private _airdropAmount = 100 * 1e18;
    uint private _totalReleasedAirdrop;
    uint private _maxAirdropAmount = 1_000_000 * 1e18;
    uint private _icoEndTime;
    uint public _holdesCount;

    mapping (address => uint) private airdrops;
    mapping (address => uint) private holders;
    mapping (address => bool) public isInList;

    event Buy(address indexed  buyerAddress,uint indexed amount);
    event Airdrop(address indexed  receiverAddress,uint indexed amount);

    constructor(address token,address admin) {
        _token = IERC20(token);
        _admin = admin;
    }
    
    //Checkers
    modifier OnlyAdmin(){
        require(msg.sender ==_admin,"OnlyAdmin");
        _;
    }
    modifier icoIsActive(){
        require(_icoEndTime > block.timestamp,"icoIsActive");
        _;
    }
    modifier icoIsDeActive(){
        require(_icoEndTime == 0,"icoIsActive");
        _;
    }

    function activate(uint duration) external OnlyAdmin icoIsDeActive{
        require(duration > 0,"duration > 0");
        _icoEndTime = block.timestamp + duration;
    }

    function deactivate() external OnlyAdmin icoIsActive{
        _icoEndTime = 0;
    }

    function depositTokens(uint amount) public 
    {
        _token.transferFrom(_admin, (address(this)), amount);
    }

    function airdrop(address receiver) external icoIsActive
    {
        require(airdrops[receiver] == 0,"airdrop : Already has that");
        require(_totalReleasedAirdrop + _airdropAmount <= _maxAirdropAmount,"_maxAirdropAmount");
        require(balanceOfTokens(address(this)) >= _airdropAmount ,"No Enought token");

        _token.transfer(receiver, _airdropAmount);

        airdrops[receiver] = _airdropAmount;
        _totalReleasedAirdrop += _airdropAmount;
        if (!isInList[receiver])
        {
            isInList[receiver] = true;
            _holdesCount++;
        }
        holders[receiver] += _airdropAmount;

        emit Airdrop(receiver,_airdropAmount);
    }

    function purchase(uint amount) external payable  icoIsActive
    {
        require(msg.value == (_tokenPrice * (amount / 1e18)),"purchase price");
         _token.transfer(msg.sender, amount);

          if (!isInList[msg.sender])
        {
            isInList[msg.sender] = true;
            _holdesCount++;
        }
        holders[msg.sender] += amount;

        emit Buy(msg.sender,amount);
    }

    function withdrawTokens(uint amount) external OnlyAdmin
    {
        require(amount <= balanceOfTokens(address(this)),"withdrawTokens");
        _token.transfer(_admin, amount);
    }

    function withdrawEth(uint amount) external OnlyAdmin 
    {
        require(amount <= balanceOfEth(address(this)),"withdrawTokens");
        payable(_admin).transfer(amount);
    }

    /*
        Utilities    
    */
    function balanceOfEth(address account) public view returns(uint)
    {
        return account.balance;
    }
    
    function balanceOfTokens(address account) public view returns(uint)
    {
        return _token.balanceOf(account);
    }

    function getICOAdr() public view returns(address) 
    {
        return address(this);
    }

    function getTokenAdr() public view returns(address) 
    {
        return address(_token);
    }

    function updateAdmin(address newAdmin) public OnlyAdmin returns(bool)
    {
        _admin = newAdmin;
        return true;
    }
}
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 MyToken sender

// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 MYICO sender

// 0x0fC5025C764cE34df352757e82f7B5c4Df39A836 MyToken

// 0x417Bf7C9dc415FEEb693B6FE313d1186C692600F MYICO