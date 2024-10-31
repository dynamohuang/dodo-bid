// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Aution} from "../src/Aution.sol";

contract AutionTest is Test {
    Aution public aution;
    address public beneficiary;
    address public bidderA;
    address public bidderB;
    address public bidderC;
    

    function setUp() public {
    
        beneficiary = vm.addr(100);
        aution = new Aution(3600,payable(beneficiary),300);
        
        bidderA = vm.addr(1);
        vm.prank(bidderA);
        vm.deal(bidderA, 500);
        aution.bid{value:20}();

        bidderB = vm.addr(2);
        vm.prank(bidderB);
        vm.deal(bidderB, 500);
        aution.bid{value:30}();

        bidderC = vm.addr(3);
        vm.prank(bidderC);
        vm.deal(bidderC, 500);
        aution.bid{value:35}();

       
    }


    //
    function testBid() public{
        assertEq(aution.highestBidder(), bidderC);
        assertEq(aution.highestBid(), 35);
        vm.prank(bidderA);
        aution.withdraw();
        assertEq(aution.getPendingReturn(bidderA) ,0);
        assertEq(aution.ended(), false);
      
        vm.prank(beneficiary);
        vm.expectRevert();
        aution.endAuction();
      
        // 快进到目标时间戳
        vm.warp(block.timestamp + 3600);
        vm.prank(beneficiary);
        aution.endAuction();
        assertEq(aution.ended(), true);

    }

    function testIncreaseTime() public{
        //还有两分钟结束
        vm.warp(aution.autionEnd() - 120);
       
        vm.prank(bidderA);
        aution.bid{value:45}();

        //延长时间成功 过四分钟 还能出价,如果revert则延时策略失败
        vm.warp(block.timestamp + 240);

        vm.prank(bidderB);
        aution.bid{value:50}();
    }



}
