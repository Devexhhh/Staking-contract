// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";

contract StakingContractTest is Test {
    StakingContract stakingContract;

    function setUp() public {
        stakingContract = new StakingContract();
    }

    function testStake() public {
        stakingContract.stake{value: 200}();
        assert(stakingContract.balanceOf(address(this)) == 200);
    }

    function testStakeUser() public {
        vm.startPrank(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696);
        vm.deal(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696, 10 ether);
        stakingContract.stake{value: 1 ether}();
        assert(
            stakingContract.balanceOf(
                address(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696)
            ) == 1 ether
        );
    }

    function testUnstake() public {
        vm.deal(address(this), 1000);
        stakingContract.stake{value: 200}();
        stakingContract.unstake(100);
        assertEq(stakingContract.balanceOf(address(this)), 100);
    }

    function test_RevertIf_UnstakeMoreThanBalance() public {
        stakingContract.stake{value: 200}();
        vm.expectRevert();
        stakingContract.unstake(300);
    }
}
