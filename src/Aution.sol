// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Aution{
    address payable public beneficiary;
    uint public autionEnd;
    uint public increaseTime;
    address public highestBidder;
    uint  public highestBid;
    mapping(address => uint) pendingReturns;
    bool public ended;

    event HightestBidIncreased(address bidder, uint amount);
    event  AuctionEnded(address winner, uint amount);

    constructor(uint _bidingtime, address payable _beneficiary,uint _increaseTime){
        beneficiary = _beneficiary;
        increaseTime = _increaseTime;
        autionEnd = block.timestamp + _bidingtime;
        ended = false;

    }
     
    function getPendingReturn(address user) external view returns (uint256) {
        return pendingReturns[user];
    }

    function bid() public payable{
        require(block.timestamp <= autionEnd, "ended");
        require(msg.value > highestBid, "too small!");

        if(highestBid > 0 ){
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        //终局延长....
        if( autionEnd - block.timestamp < increaseTime ){
            autionEnd = block.timestamp + increaseTime;
        }
        emit HightestBidIncreased(msg.sender, highestBid);
    }

    function withdraw() public returns(bool){
        uint amount =  pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
        return true;
    }

    function endAuction() public{
        require(block.timestamp >= autionEnd);
        require(!ended,"has already benen called");
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }

}
