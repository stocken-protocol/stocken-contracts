// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721A} from "erc721a/contracts/ERC721A.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title Stocken NFT Contract
contract Stocken is ERC721A, Ownable {
    string private _baseTokenURI;

    event UpdateBaseURI(string baseURI);

    constructor() ERC721A("Stocken", "STK") {}

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    //===============================================================
    //                      Setter Functions
    //===============================================================

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
        emit UpdateBaseURI(baseURI);
    }
}
