// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {InternalQuinaryIMT, QuinaryIMTData} from "./InternalQuinaryIMT.sol";
import {PoseidonT6} from "poseidon-solidity/PoseidonT6.sol";

library QuinaryIMT {
    using InternalQuinaryIMT for *;

    function hasher(uint256[5] memory inputs) internal pure returns (uint256) {
        return PoseidonT6.hash(inputs);
    }

    function init(QuinaryIMTData storage self, uint256 depth, uint256 zero) public {
        InternalQuinaryIMT._init(self, depth, zero, hasher);
    }

    function insert(QuinaryIMTData storage self, uint256 leaf) public {
        InternalQuinaryIMT._insert(self, leaf, hasher);
    }

    function update(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256 newLeaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) public {
        InternalQuinaryIMT._update(self, leaf, newLeaf, proofSiblings, proofPathIndices, hasher);
    }

    function remove(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) public {
        InternalQuinaryIMT._remove(self, leaf, proofSiblings, proofPathIndices, hasher);
    }

    function verify(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) private view returns (bool) {
        return InternalQuinaryIMT._verify(self, leaf, proofSiblings, proofPathIndices, hasher);
    }
}
