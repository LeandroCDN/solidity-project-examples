// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Marketplace is Ownable{
    struct NFT {
        address nftAddress;
        uint256 tokenId; // ID del NFT
        address owner; // Dirección del dueño actual del NFT
        uint256 price; // Precio del NFT en la moneda del marketplace
        bool isListed; // Indica si el NFT está listado para la venta
    }

    IERC20 currency;
    mapping(address nftAddress => mapping(uint256 nftId=> NFT)) public nfts;


    event NFTListed(uint256 indexed tokenId, uint256 price);
    event NFTSold(uint256 indexed tokenId, uint256 price, address buyer);

    constructor(address currency_) {
        currency = IERC20(currency_);
    }

    function setCurrency(address currency_) public onlyOwner {
        currency = IERC20(currency_);
    }

    // Función para listar un NFT para la venta en el marketplace, with aproved function
    function listNFT(address nftAddress, uint256 tokenId, uint256 price) external {
        require(msg.sender == IERC721(nftAddress).ownerOf(tokenId), "You are not the owner of this NFT");
        require(!nfts[nftAddress][tokenId].isListed, "NFT is already listed for sale");

        nfts[nftAddress][tokenId] = NFT(nftAddress,tokenId, msg.sender, price, true);
        emit NFTListed(tokenId, price);
    }

    // Función para comprar un NFT del marketplace
    function buyNFT(address nftAddress, uint256 tokenId) external {
        NFT storage nft = nfts[nftAddress][tokenId];
        require(nft.isListed, "NFT is not listed for sale");

        uint256 price = nft.price;
        address seller = nft.owner;

        currency.transferFrom(msg.sender, seller, price);
        IERC721(nftAddress).safeTransferFrom(seller, msg.sender, tokenId);

        nft.isListed = false;
        nft.owner = msg.sender;

        emit NFTSold(tokenId, price, msg.sender);
    }
}
/* task
*   Unlist func
*   Market Fees
*   Remake all contract to hold in this contract all nfts on sale
*   Sale under time, like only open for 6 days 
*/