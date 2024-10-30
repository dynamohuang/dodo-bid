// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
contract Auction{
    address payable public beneficiary;
    uint public autionEnd;
    address public hightestBidder;
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
            pendingReturns[hightestBidder] += highestBid;
        }
        hightestBidder = msg.sender;
        hightestBid = msg.value;
        emit HightestBidIncreased(bidder, amount);
    }

}
