// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {InternalLeanIMT, LeanIMTData} from "./InternalLeanIMT.sol";
import {SNARK_SCALAR_FIELD} from "./Constants.sol";
import {IHasherT3} from "./interfaces/IHasherT3.sol";

library LeanIMT {
    using InternalLeanIMT for *;

    function hasher(uint256[2] memory inputs) internal view returns (uint256) {
        return IHasherT3(0x3333333C0A88F9BE4fd23ed0536F9B6c427e3B93).hash(inputs);
    }

    function insert(LeanIMTData storage self, uint256 leaf) public returns (uint256) {
        return InternalLeanIMT._insert(self, leaf, hasher, SNARK_SCALAR_FIELD);
    }

    function insertMany(LeanIMTData storage self, uint256[] calldata leaves) public returns (uint256) {
        return InternalLeanIMT._insertMany(self, leaves, hasher, SNARK_SCALAR_FIELD);
    }

    function update(
        LeanIMTData storage self,
        uint256 oldLeaf,
        uint256 newLeaf,
        uint256[] calldata siblingNodes
    ) public returns (uint256) {
        return InternalLeanIMT._update(self, oldLeaf, newLeaf, siblingNodes, hasher, SNARK_SCALAR_FIELD);
    }

    function remove(
        LeanIMTData storage self,
        uint256 oldLeaf,
        uint256[] calldata siblingNodes
    ) public returns (uint256) {
        return InternalLeanIMT._remove(self, oldLeaf, siblingNodes, hasher, SNARK_SCALAR_FIELD);
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
