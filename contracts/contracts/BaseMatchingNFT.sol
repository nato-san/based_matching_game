// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BaseMatchingNFT
 * @dev ERC-721 NFT contract for Based Matching Game
 * Deployed on Base chain (Chain ID: 8453)
 */
contract BaseMatchingNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    
    // Base URI for metadata
    string private _baseTokenURI;
    
    // Minting price (can be 0 for free minting)
    uint256 public mintPrice = 0;
    
    // Maximum supply (0 = unlimited)
    uint256 public maxSupply = 0;
    
    // Mapping to track if an address has minted a specific image
    mapping(address => mapping(string => bool)) private _mintedByUser;
    
    event Minted(address indexed to, uint256 indexed tokenId, string tokenURI);
    
    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC721(name, symbol) Ownable(initialOwner) {
        _baseTokenURI = "";
        _nextTokenId = 1; // Start from token ID 1
    }
    
    /**
     * @dev Mint a new NFT
     * @param to Address to mint the NFT to
     * @param tokenURI URI for the token metadata
     */
    function mint(address to, string memory tokenURI) public returns (uint256) {
        // Check max supply if set
        if (maxSupply > 0) {
            require(_nextTokenId <= maxSupply, "Max supply reached");
        }
        
        // Get current token ID and increment
        uint256 newTokenId = _nextTokenId;
        _nextTokenId++;
        
        // Mint the token
        _safeMint(to, newTokenId);
        
        // Set token URI
        _setTokenURI(newTokenId, tokenURI);
        
        emit Minted(to, newTokenId, tokenURI);
        
        return newTokenId;
    }
    
    /**
     * @dev Get total supply
     */
    function totalSupply() public view returns (uint256) {
        return _nextTokenId - 1;
    }
    
    /**
     * @dev Set base URI
     */
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }
    
    /**
     * @dev Set mint price
     */
    function setMintPrice(uint256 price) public onlyOwner {
        mintPrice = price;
    }
    
    /**
     * @dev Set max supply
     */
    function setMaxSupply(uint256 supply) public onlyOwner {
        maxSupply = supply;
    }
    
    /**
     * @dev Override base URI
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }
}
