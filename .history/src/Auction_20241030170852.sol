// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
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
        emit HightestBidIncreased(msg.sender, highestBid);
    }

    function withdraw() public returns(bool){
        uint

    }

}
