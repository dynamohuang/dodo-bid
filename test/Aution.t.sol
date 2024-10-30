// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Aution} from "../src/Aution.sol";

contract AutionTest is Test {
    Aution public aution;
    address public beneficiary;
    

    function setUp() public {
    
        beneficiary = vm.addr(1);
        aution = new Aution(30,payable(beneficiary),10);
       
    }

    //
    function testBid() public{
        
        address bidderA = vm.addr(2);
        vm.prank(bidderA);
        vm.deal(bidderA, 50);
        aution.bid{value:20}();
        assertEq(aution.highestBidder(), bidderA);
        assertEq(aution.highestBid(), 20);
    }
}
