// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Cactuz is ERC721 {

    struct CTZ {

        string name;
        string img;
        uint level;

    }

    CTZ[] public cactuz;
    address public gameOwner;

    constructor() ERC721("RhR_Cactuz", "CTZ") {

        gameOwner = msg.sender;

    }

    modifier onlyOwnerOf(uint ctzId) {

        require(ownerOf(ctzId) == msg.sender, "Just the owner can battle using this cactuz");
        _;

    }

    function battle(uint attackingCtz, uint defendingCtz) public onlyOwnerOf(attackingCtz) {
        
        CTZ storage attacker = cactuz[attackingCtz];
        CTZ storage defender = cactuz[defendingCtz];

         if (attacker.level >= defender.level) {

            attacker.level += 2;
            defender.level += 1;

        } else {

            attacker.level += 1;
            defender.level += 2;
        
        }
    }

    function createNewCtz(string memory name, address to, string memory img) public {
        
        require(msg.sender == gameOwner, "Just the owner can battle using this cactuz");
        
        uint id = cactuz.length;

        cactuz.push(CTZ(name, img, 1));

        _safeMint(to, id);

    }
}
