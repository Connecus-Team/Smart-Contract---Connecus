// SPDX-License-Identifier: MIT

pragma solidity >=0.7.8;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Tasking is  ReentrancyGuard, Context{

    event NewTask(uint256 id,uint256 sumTask,uint256 timeTaskEnd);

    struct infoTask{
        address chairPerson;
        uint256 sumTask;
        uint256 timeTaskEnd;
        uint256 totalReward;
        mapping (address => uint256) checkTask;
    }

    mapping (uint256 => infoTask) public ownerToTask;

    function CreateTask(uint256 _id,uint256 _sumTask,uint256 _timeEnd) public {
        infoTask storage _in = ownerToTask[_id];
        _in.chairPerson = _msgSender();
        _in.sumTask = _sumTask;
        _in.timeTaskEnd = _timeEnd;
        emit NewTask(_id,_sumTask,_timeEnd);
    }

    function _personTask(uint256 _id,uint256 _sumTask) internal {
        infoTask storage _in = ownerToTask[_id];
        _in.checkTask[_msgSender()] = _sumTask;
    }

    // thời gian hết hạn Task
    function getTimeTaskEnd(uint256 _id) public view returns(uint256){
        return ownerToTask[_id].timeTaskEnd;
    }
    
}