// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/* **In progress** */

contract Crowdfunding is ERC721, Ownable {
    using Strings for uint256;

    struct Project {
        bytes32 encryptedTitle;
        bytes32 encryptedDescription;
        uint256 targetAmount;
        uint256 deadline;
        uint256 totalAmount;
        bool funded;
    }

    Project[] public projects;
    mapping(uint256 => address) public projectCreators;

    constructor() ERC721("Crowdfunding", "CF") {}

    function createProject(
        bytes32 encryptedTitle,
        bytes32 encryptedDescription,
        uint256 targetAmount,
        uint256 deadline
    ) external {
        uint256 projectId = projects.length;
        projects.push(
            Project(encryptedTitle, encryptedDescription, targetAmount, deadline, 0, false)
        );
        projectCreators[projectId] = msg.sender;
        _safeMint(msg.sender, projectId);
    }

    function getProject(uint256 projectId) external view returns (bytes32, bytes32, uint256, uint256, uint256, bool) {
        require(_exists(projectId), "Invalid project ID");
        Project memory project = projects[projectId];
        return (
            project.encryptedTitle,
            project.encryptedDescription,
            project.targetAmount,
            project.deadline,
            project.totalAmount,
            project.funded
        );
    }

    function contribute(uint256 projectId) external payable {
        require(_exists(projectId), "Invalid project ID");
        require(!projects[projectId].funded, "Project already funded");
        require(
            block.timestamp <= projects[projectId].deadline,
            "Project deadline passed"
        );

        projects[projectId].totalAmount = projects[projectId].totalAmount + msg.value;

        if (projects[projectId].totalAmount >= projects[projectId].targetAmount) {
            projects[projectId].funded = true;
        }
    }

    function withdrawFunds(uint256 projectId) external {
        require(projects[projectId].funded, "Project not funded");
        require(
            msg.sender == projectCreators[projectId],
            "Only project creator can withdraw funds"
        );

        uint256 amount = projects[projectId].totalAmount;
        projects[projectId].totalAmount = 0;
        payable(msg.sender).transfer(amount);
    }

    function getProjectURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Invalid token ID");
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return getProjectURI(tokenId);
    }

    function baseURI() public pure returns (string memory) {
        return "https://example.com/projects/";
    }
}
