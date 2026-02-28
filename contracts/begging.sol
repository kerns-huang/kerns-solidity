// SPDX-License-Identifier: GPL-3.0

pragma solidity ^ 0.8.13;

//作业2 ，讨饭合约
contract BeggingContract{

  // 合约主人   
  address internal  owner; 

  // 每个人的捐赠余额
  mapping(address => uint) public beggingBalance;

  constructor() {
    owner = msg.sender; 
  }

  event LogDonate(address sender, uint money);

  //用户捐赠。
  function donate(uint money) external payable   {
      require(money > 0 , "donate money need more than zero");
      // 当前用户的捐赠金额添加，
      beggingBalance[msg.sender]= beggingBalance[msg.sender]+money;
      // 发送事件
      emit LogDonate(msg.sender,money);
      
  }

  // 提现，正常只有合约主人才能操作
  function withdraw() external     {
    // 当前合约的余额全部转给合约主人
    require(owner == msg.sender, "only owner");
    (bool success, ) = payable(owner).call{value: address(this).balance}("");
    require(success, "Transfer failed");
  }

  // 查询某个人的捐赠金额
  function getDonation(address sender) external view returns (uint) {
      return beggingBalance[sender];
  }

}