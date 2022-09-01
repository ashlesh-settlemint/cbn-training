// SPDX-License-Identifier: MIT
// SettleMint.com

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Bond is ERC721 {
  struct BondDetails {
    uint256 bondId;
    uint256 faceValue;
    uint256 couponRate;
    uint256 maturityTimestamp;
  }

  mapping(uint256 => BondDetails) public bondToDetails;

  constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

  function createBond(
    uint256 bondId,
    uint256 faceValue,
    uint256 couponRate,
    uint256 maturityTimestamp
  ) external {
    require(bondToDetails[bondId].bondId != bondId, "Bond already exist");

    BondDetails memory bond = BondDetails(bondId, faceValue, couponRate, maturityTimestamp);
    bondToDetails[bondId] = bond;
  }

  function mintBond(address to, uint256 bondId) external {
    require(bondToDetails[bondId].bondId == bondId, "Bond does not exist");
    require(bondToDetails[bondId].maturityTimestamp > block.timestamp, "Bond is already matured");

    _mint(to, bondId);
  }

  function burnBond(uint256 bondId) external {
    require(bondToDetails[bondId].bondId == bondId, "Bond does not exist");
    require(bondToDetails[bondId].maturityTimestamp < block.timestamp, "Bond is not matured");

    _burn(bondId);
  }
}
