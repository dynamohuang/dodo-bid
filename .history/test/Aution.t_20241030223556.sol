// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Aution} from "../src/Aution.sol";

contract AutionTest is Test {
    Aution public aution;
    address public beneficiary;

    function setUp() public {
    
        beneficiary = vm.address()
        aution = new Aution(600,beneficiary);
       
    }

    //
}
