// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract TokenERC20 is ERC20{
    address public admin;
    constructor(uint amount) ERC20("myToken","MTK"){
        admin = msg.sender;
        _mint(admin,amount * 10 ** decimals());
    }
}

