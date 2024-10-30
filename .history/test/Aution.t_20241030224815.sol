// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Aution} from "../src/Aution.sol";

contract AutionTest is Test {
    Aution public aution;
    address public beneficiary;
    

    function setUp() public {
    
        beneficiary = vm.address()
        aution = new Aution(30,beneficiary,10);
       
    }

    //
    function testBid public(){
        address public bidderA = vm.address()
        vm.prank(bidderA)
        aution.bid{value:20}()
        assertEq(pendingReturns[bidderA], x);
    }
}