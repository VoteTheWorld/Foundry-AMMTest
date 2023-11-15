//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/Mock/MockV3Aggregator.sol";

contract HelperConfig is Script {
    NetworkConfig public config;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    struct NetworkConfig {
        address priceFeedETHUSD;
        address priceFeedBTCUSD;
    }

    event HelperConfig__CreatedMockPriceFeed(address priceFeed);

    constructor() {
        if (block.chainid == 1) {
            config = getMainnetConfig();
        } else if (block.chainid == 11155111) {
            config = getSepoliaConfig();
        } else {
            config = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                priceFeedETHUSD: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
                priceFeedBTCUSD: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
    }

    function getMainnetConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                priceFeedETHUSD: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
                priceFeedBTCUSD: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
            });
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (config.priceFeedETHUSD != address(0)) {
            return config;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();
        emit HelperConfig__CreatedMockPriceFeed(address(mockPriceFeed));
        return
            NetworkConfig({
                priceFeedETHUSD: address(mockPriceFeed),
                priceFeedBTCUSD: address(mockPriceFeed)
            });
    }

    function getPriceFeedETHUSD() public view returns (address) {
        return config.priceFeedETHUSD;
    }

    function getPriceFeedBTCUSD() public view returns (address) {
        return config.priceFeedBTCUSD;
    }
}
