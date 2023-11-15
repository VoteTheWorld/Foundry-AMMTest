//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {AMMTest} from "../src/AMMTest.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployAMMTest is Script {
    function run() external returns (AMMTest, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        address priceFeed = helperConfig.getPriceFeedETHUSD();
        vm.startBroadcast();
        AMMTest ammTest = new AMMTest(priceFeed);
        vm.stopBroadcast();
        return (ammTest, helperConfig);
    }
}
