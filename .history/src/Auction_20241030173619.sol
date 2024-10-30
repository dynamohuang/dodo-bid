// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;;
contract Auction{
    address payable public beneficiary;
    uint public autionEnd;
    address public highestBidder;
    uint  public highestBid;
    mapping(address => uint) pendingReturns;
    bool ended;

    event HightestBidIncreased(address bidder, uint amount);
    event  AuctionEnded(address winner, uint amount);

    constructor(uint _bidingtime, address payable _benficiary){
        beneficiary = _benficiary;
        autionEnd = block.timestamp + _bidingtime;
    }

    function bid() public payable{
        require(block.timestamp <= autionEnd);
        require(msg.value > highestBid);

        if(highestBid > 0 ){
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        //终局延长五分钟
        increaseTtime = 300
        if( autionEnd - block.timestamp < increaseTtime ){
            autionEnd = block.timestamp + increaseTtime;
        }
        

        emit HightestBidIncreased(msg.sender, highestBid);
    }

    function withdraw() public returns(bool){
        uint amount =  pendingReturns(msg.sender);
        if(amount > 0){
            pendingReturns[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
        return true;
    }

    function endAuction() public{
        require(block.timestamp >= auctionEnd," not yet ended!");
        require(!ended,"has already benen called");
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }

}
