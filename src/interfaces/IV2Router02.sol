// License 
// SPDX-License-Identifier: MIT

// Solidity compiler version
pragma solidity 0.8.24;

// Interface
interface IV2Router02{
  function swapExactTokensForTokens(
  uint amountIn,
  uint amountOutMin,
  address[] calldata path,
  address to,
  uint deadline
) external returns (uint[] memory amounts);
}