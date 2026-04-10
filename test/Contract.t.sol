// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
    StakingContract c;

    function setUp() public {
        c = new StakingContract();
    }

    function testStake() public {
        uint value = 10 ether;
        c.stake{value: value}(value);

        assert(c.totalStake() == value);
    }

    function test_RevertIfStakeWithoutValue() public {
        uint value = 10 ether;

        vm.expectRevert();
        c.stake(value);
    }

    function testUnstake() public {
        uint value = 10 ether;
        vm.startPrank(0x68358E4291918118D41598b00c37e0513DC4fae9);
        vm.deal(0x68358E4291918118D41598b00c37e0513DC4fae9, value);
        c.stake{value: value}(value);
        c.unstake(value);

        assert(c.totalStake() == 0);
    }
}
