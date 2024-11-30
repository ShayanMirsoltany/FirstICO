// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract TokenERC20 is ERC20{
    address public admin;
    constructor() ERC20("MyToken","MTK"){
        _mint(msg.sender,1000 * 10 ** decimals());
        admin = msg.sender;
    }
}

