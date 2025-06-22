// License 
// SPDX-License-Identifier: MIT

// Solidity compiler version
pragma solidity 0.8.24;

// Libraries
import "./interfaces/IV2Router02.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

// Contract
contract swapApp {

    using SafeERC20 for IERC20;

    // Variables
    address public V2Router02Address;

    // Events
    event e_swapTokens(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);

    // Constructor
    constructor(address V2Router02Address_){
        V2Router02Address = V2Router02Address_;
    }

    function swapTokens(uint256 amountIn_, uint256 amountOutMin_, address[] memory path_, uint256 deadline_) external {
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        IERC20(path_[0]).approve(V2Router02Address, amountIn_);
        uint256[] memory amountOuts = IV2Router02(V2Router02Address).swapExactTokensForTokens(amountIn_, amountOutMin_, path_, msg.sender, deadline_);
        emit e_swapTokens(path_[0], path_[path_.length - 1], amountIn_, amountOuts[amountOuts.length - 1]);
    }

}