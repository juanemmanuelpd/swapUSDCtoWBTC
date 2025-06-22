// License 
// SPDX-License-Identifier: MIT

// Solidity compiler version
pragma solidity 0.8.24;

// Libraries
import "forge-std/Test.sol";
import "../src/swapApp.sol";

// Contract
contract swapAppTest is Test{

    swapApp app;

    // Variables
    address uniswapV2SwapRouterAddress = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24;
    address user = 0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX; // Address with USDC in Arbitrum Mainnet
    address tokenUSDC = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831; // USDC address in Arbitrum Mainnet
    address tokenWBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f; // WBTC address in Arbitrum Mainnet

    // Set Up
    function setUp() public{
        app = new swapApp(uniswapV2SwapRouterAddress);
    }

    // Testing functions

    function testHasBeenDeployedCorrectly() public view {
        assert(app.V2Router02Address() == uniswapV2SwapRouterAddress);
    }

    function testSwapTokensCorrectly() public {
        vm.startPrank(user);
        uint256 amountIn = 5 * 1e6;
        uint256 amountOutMin = 0 * 1e8;
        IERC20(tokenUSDC).approve(address(app), amountIn);
        uint256 deadline = 1750575668 + 100000000000;
        address[] memory path = new address[](2);
        path[0] = tokenUSDC; 
        path[1] = tokenWBTC;
        uint256 usdcBalanceBefore = IERC20(tokenUSDC).balanceOf(user);
        uint256 daiBalanceBefore = IERC20(tokenWBTC).balanceOf(user);
        app.swapTokens(amountIn, amountOutMin, path, deadline);
        uint256 usdcBalanceAfter = IERC20(tokenUSDC).balanceOf(user);
        uint256 daiBalanceAfter = IERC20(tokenWBTC).balanceOf(user);
        assert(usdcBalanceAfter == usdcBalanceBefore - amountIn);
        assert(daiBalanceAfter > daiBalanceBefore);
        vm.stopPrank();
    }

}