//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";
import {AMMTest} from "../../src/AMMTest.sol";
import {DeployAMMTest} from "../../script/DeployAMMTest.s.sol";
import {console} from "forge-std/Script.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract AMMTestTest is Test {
    AMMTest ammTest;
    HelperConfig helperConfig;

    function setUp() external {
        DeployAMMTest deployAMMTest = new DeployAMMTest();
        (ammTest, helperConfig) = deployAMMTest.run();
    }

    function testPrice() external {
        uint256 result = ammTest.check();
        assertEq(result, 0);
    }

    function testSmallPrice() external {
        ammTest.addX(1e8);
        uint256 result = ammTest.check();
        assertEq(result, 0);
    }

    function testBigPrice() external {
        ammTest.addY(500e8);
        uint256 result = ammTest.check();
        assertEq(result, 1);
    }
}
