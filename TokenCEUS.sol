// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Token is Ownable, ERC20Burnable {
    constructor() ERC20("Connecus", "CEUS") {
        _mint(msg.sender, 10**9 * 10**18);
    }
}
// 0x0230E3760B53b08426d15aaf5A327ED6d0Dd36B7