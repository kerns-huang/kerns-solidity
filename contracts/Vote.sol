// SPDX-License-Identifier: GPL-3.0

pragma solidity ^ 0.8.13;

contract Vote{
    // 用户投票数
    mapping(address => uint256) private _userVote;
    address[] private _voters;
    // 记录某个地址是否已在当前版本的_voters数组中
    mapping(address => bool) private _isInVoters;
    
    //投票给某个用户
    function vote(address voter) external  {
        if(!_isInVoters[voter]){
            _voters.push(voter);
            _isInVoters[voter]=true;    
        }
        _userVote[voter] += 1;
    }

    // 返回某个候选人的投票数
    function getVotes(address voter) view public returns (uint256) {
        return _userVote[voter];
    }
    
    // 重置所有候选人的得票数
    function resetVotes() external  {
        uint voterCount = _voters.length;
        for(uint i=0;i < voterCount;i++){
            _userVote[_voters[i]] = 0;
        }
    }

}