// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
contract Auction{
    address payable public beneficiary;
    uint public auctionEnd;
    address public hightestBidder;
    uint  public hightestBid;
    mapping(address => uint) pendingReturns;
    bool ended;

    event HightestBidIncreased(address bidder, uint amount);
    event  AuctionEnded(address winner, unint amount);

    constructor(uint _bindingtime, address payable _benficiary){

    }

}
