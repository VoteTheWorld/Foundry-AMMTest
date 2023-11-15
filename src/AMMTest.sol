// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {AggregatorV3Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract AMMTest {
    uint256 private x = 1e8;
    uint256 private y = 2000e8;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function addX(uint256 a) public {
        x += a;
    }

    function addY(uint256 a) public {
        y += a;
    }

    function getLatestPrice() public view returns (int) {
        (, int price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    function check() public view returns (uint256) {
        uint256 price = (y / x) * 1e8;
        uint256 feedPrice = uint256(getLatestPrice());
        if (price > feedPrice) {
            return 1;
        } else {
            return 0;
        }
    }

    function getX() public view returns (uint256) {
        return x;
    }

    function getY() public view returns (uint256) {
        return y;
    }
}
