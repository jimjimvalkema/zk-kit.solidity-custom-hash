// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {InternalLeanIMT, LeanIMTData} from "./InternalLeanIMT.sol";
import {SNARK_SCALAR_FIELD} from "./Constants.sol";

library LeanIMT {
    address internal constant HASHER_ADDRESS = 0x3333333C0A88F9BE4fd23ed0536F9B6c427e3B93;

    using InternalLeanIMT for *;

    function insert(LeanIMTData storage self, uint256 leaf) public returns (uint256) {
        return InternalLeanIMT._insert(self, leaf, HASHER_ADDRESS, SNARK_SCALAR_FIELD);
    }

    function insertMany(LeanIMTData storage self, uint256[] calldata leaves) public returns (uint256) {
        return InternalLeanIMT._insertMany(self, leaves, HASHER_ADDRESS, SNARK_SCALAR_FIELD);
    }

    function update(
        LeanIMTData storage self,
        uint256 oldLeaf,
        uint256 newLeaf,
        uint256[] calldata siblingNodes
    ) public returns (uint256) {
        return InternalLeanIMT._update(self, oldLeaf, newLeaf, siblingNodes, HASHER_ADDRESS, SNARK_SCALAR_FIELD);
    }

    function remove(
        LeanIMTData storage self,
        uint256 oldLeaf,
        uint256[] calldata siblingNodes
    ) public returns (uint256) {
        return InternalLeanIMT._remove(self, oldLeaf, siblingNodes, HASHER_ADDRESS, SNARK_SCALAR_FIELD);
    }

    function has(LeanIMTData storage self, uint256 leaf) public view returns (bool) {
        return InternalLeanIMT._has(self, leaf);
    }

    function indexOf(LeanIMTData storage self, uint256 leaf) public view returns (uint256) {
        return InternalLeanIMT._indexOf(self, leaf);
    }

    function root(LeanIMTData storage self) public view returns (uint256) {
        return InternalLeanIMT._root(self);
    }
}
