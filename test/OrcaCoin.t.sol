// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/OrcaCoin.sol";

contract OrcaCoinTest is Test {
    OrcaCoinContract orcaCoin;

    function setUp() public {
        orcaCoin = new OrcaCoinContract(address(this));
    }

    function testInitialSupply() public view {
        assert(orcaCoin.totalSupply() == 0);
    }

    function test_RevertIf_MintFails() public {
        vm.expectRevert();
        vm.startPrank(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696);
        orcaCoin.mint(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696, 10);
    }

    function testMint() public {
        orcaCoin.mint(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696, 10);
        assert(
            orcaCoin.balanceOf(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696) == 10
        );
    }

    function testChangeStakingContract() public {
        orcaCoin.updateStakingContract(
            0x90a254BEc9164E08a1990F5B90757DE6b3CF5696
        );
        vm.startPrank(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696);
        orcaCoin.mint(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696, 10);
        assert(
            orcaCoin.balanceOf(0x90a254BEc9164E08a1990F5B90757DE6b3CF5696) == 10
        );
    }
}
