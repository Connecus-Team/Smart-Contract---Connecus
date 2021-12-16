// SPDX-License-Identifier: MIT

pragma solidity >=0.7.8;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Voting is  ReentrancyGuard, Context{

    event NewVote(uint256 id,string tile,uint256 sumOption);
    struct infoVote{
        string title;
        address chairPerson;
        uint256 sumOption;
        mapping (address => bool) checkPresonVote;
        mapping (uint256 => address[]) Option;
    }

    mapping (uint256 => infoVote) public VoteToOwer;
    mapping (address => uint) ownerVoteCount;

    function CreateVote(uint256 _id,string memory _tile,uint256 _sumOption) public {
        infoVote storage _in = VoteToOwer[_id];
        _in.title = _tile;
        _in.chairPerson = _msgSender();
        _in.sumOption = _sumOption;
        emit NewVote(_id,_tile,_sumOption);
    }

    function PersonVote(uint256 _id,uint256 _idOption) public {
        infoVote storage _in = VoteToOwer[_id];
        require(_in.checkPresonVote[_msgSender()] == false, "you only vote once");
        _in.Option[_idOption].push(_msgSender());
        _in.checkPresonVote[_msgSender()] = true;
    }

}
