// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FriendTech is ERC20 {
    address public owner;

    mapping(address => uint256) private sharePrice;
    mapping(address => uint256) public totalShares;
    mapping(address => uint256) public dividends;

    constructor() ERC20("FriendTech", "FTK") {
        owner = msg.sender;
    }

    function setSharePrice(uint256 price) external {
        require(price > 0, "Price must be greater than zero");
        sharePrice[msg.sender] = price;
    }

    function getSharePrice(address user) public view returns (uint256) {
        return sharePrice[user];
    }

    function setTotalShares(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        totalShares[msg.sender] = amount;
    }

    function getTotalShares(address user) public view returns (uint256) {
        return totalShares[user];
    }

    function distributeDividends() external payable {
        require(msg.sender == owner, "Only the owner can distribute dividends");
        require(address(this).balance > 0, "No ether available for dividends");

        for (address shareholder : totalShares.keys()) {
            uint256 share = totalShares[shareholder];
            uint256 dividendPayment = (dividendPerShare * share) - dividends[shareholder];
            dividends[shareholder] += dividendPayment;
            payable(shareholder).transfer(dividendPayment);
        }
    }

    function buyShares(address seller, uint256 amount) external payable {
        // Same as before
    }

    function sellShares(address buyer, uint256 amount) external {
        // Same as before
    }

    function transferShares(address to, uint256 amount) external {
        // Same as before
    }
}