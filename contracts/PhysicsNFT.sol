// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721A} from "erc721a/contracts/ERC721A.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 ______     ______   ______     ______     __  __     ______     __   __
/\  ___\   /\__  _\ /\  __ \   /\  ___\   /\ \/ /    /\  ___\   /\ "-.\ \ 
\ \___  \  \/_/\ \/ \ \ \/\ \  \ \ \____  \ \  _"-.  \ \  __\   \ \ \-.  \
 \/\_____\    \ \_\  \ \_____\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_\\"\_\
  \/_____/     \/_/   \/_____/   \/_____/   \/_/\/_/   \/_____/   \/_/ \/_/
 ______   ______     ______     ______   ______     ______     ______     __
/\  == \ /\  == \   /\  __ \   /\__  _\ /\  __ \   /\  ___\   /\  __ \   /\ \
\ \  _-/ \ \  __<   \ \ \/\ \  \/_/\ \/ \ \ \/\ \  \ \ \____  \ \ \/\ \  \ \ \____
 \ \_\    \ \_\ \_\  \ \_____\    \ \_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\
  \/_/     \/_/ /_/   \/_____/     \/_/   \/_____/   \/_____/   \/_____/   \/_____/
*/

/// @title Stocken physics NFT contract
/// @dev This contract is used to mint ownership of physical assets.
contract PhysicsNFT is ERC721A, AccessControl, Ownable {
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
    bytes32 public constant BURNER_ROLE = keccak256('BURNER_ROLE');

    string private _baseTokenURI;

    event UpdateBaseURI(string baseURI);

    constructor(string memory __baseTokenURI) ERC721A("PhysicsNFT", "PNFT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(BURNER_ROLE, msg.sender);

        _baseTokenURI = __baseTokenURI;
    }

    modifier onlyMinter() {
        require(hasRole(MINTER_ROLE, msg.sender), "Minter: permission denied");
        _;
    }

    modifier onlyBurner() {
        require(hasRole(MINTER_ROLE, msg.sender), "Minter: permission denied");
        _;
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    //===============================================================
    //                    Minting and Burning Functions
    //===============================================================

    function mint(uint256 quantity) external onlyMinter {
        _mint(msg.sender, quantity);
    }

    function burn(uint256 tokenId) external onlyBurner {
        _burn(tokenId, true);
    }

    //===============================================================
    //                      Setter Functions
    //===============================================================

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
        emit UpdateBaseURI(baseURI);
    }

    //===============================================================
    //                   SupportsInterface
    //===============================================================

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, ERC721A)
        returns (bool)
    {
        return
            ERC721A.supportsInterface(interfaceId) ||
            AccessControl.supportsInterface(interfaceId);
    }
}
