// SPDX-License-Identifier: MIT

pragma solidity >=0.7.8;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Voting is  ReentrancyGuard, Context{

    event NewVote(uint256 id,uint256 sumOption,uint256 timeVoteEnd);
    struct infoVote{
        address chairPerson;
        uint256 sumOption;
        uint256 timeVoteEnd;
        mapping (address => bool) checkPresonVote;
        mapping (uint256 => address[]) Option;
    }

    mapping (uint256 => infoVote) public VoteToOwer;
    mapping (address => uint) ownerVoteCount;

    function CreateVote(uint256 _id,uint256 _sumOption,uint256 _timeEnd) external nonReentrant {
        infoVote storage _in = VoteToOwer[_id];
        _in.chairPerson = _msgSender();
        _in.sumOption = _sumOption;
        _in.timeVoteEnd = _timeEnd;
        emit NewVote(_id,_sumOption,_timeEnd);
    }

    function PersonVote(uint256 _id,uint256 _idOption) external nonReentrant {
        if (block.timestamp > VoteToOwer[_id].timeVoteEnd )
            revert("Voting time out");
        infoVote storage _in = VoteToOwer[_id];
        require(_in.checkPresonVote[_msgSender()] == false, "you only vote once");
        _in.Option[_idOption].push(_msgSender());
        _in.checkPresonVote[_msgSender()] = true;
    }

}

