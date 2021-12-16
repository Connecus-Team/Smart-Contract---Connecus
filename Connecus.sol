// SPDX-License-Identifier: MIT

pragma solidity >=0.7.8;

import "./ApetasticERC20.sol";
import "./Voting/Voting.sol";
import "./Funding/Funding.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ApetasticERC20Factory is Voting, Funding {
    using SafeERC20 for IERC20;
    IERC20 public immutable token;

    address public beneficiary;
    address[] public allTokens;

    mapping (address => bool) _checkStaking;

    event TokenCreated(address indexed tokenAddress, uint256 startingSupply);
    event TransferBeneficiary(address indexed oldBeneficiary, address indexed beneficiary);
    event SweepToken(IERC20 indexed token, address indexed beneficiary, uint256 balance);
    // event Approval(address owner, address spender, uint256 value);
    /// @dev On contract creation the beneficiary (and owner) are set to msg.sender

    constructor(address rewardToken_) {
        beneficiary = msg.sender;
        token = IERC20(rewardToken_);
    }

    /// @notice Return the number of tokens created by this contract
    function allTokensLength() external view returns (uint) {
        return allTokens.length;
    }
    // task create Voting

    // task create token 
    function createToken(string memory name, string memory symbol, uint256 supply) external returns (address) {
        ApetasticERC20 token_ = new ApetasticERC20(name, symbol, msg.sender, supply);
        allTokens.push(address(token_));
        emit TokenCreated(address(token_), supply);
        return address(token_);
    }

    // Task staking
    function staking(uint256 fee_) external nonReentrant {
        token.safeTransferFrom(_msgSender(), address(this), fee_ * 10 ** 18);
        _checkStaking[_msgSender()] = true;
    }

    function checkStake() public view returns(bool){
        return _checkStaking[_msgSender()];
    }
    
}