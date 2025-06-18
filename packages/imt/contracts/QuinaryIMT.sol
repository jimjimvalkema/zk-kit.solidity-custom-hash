// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {InternalQuinaryIMT, QuinaryIMTData} from "./InternalQuinaryIMT.sol";
import {PoseidonT6} from "poseidon-solidity/PoseidonT6.sol";
import {SNARK_SCALAR_FIELD} from "./Constants.sol";
error ValueGreaterThanSnarkScalarField();

library QuinaryIMT {
    using InternalQuinaryIMT for *;

    function hasher(uint256[5] memory inputs) internal pure returns (uint256) {
        if (
            inputs[0] >= SNARK_SCALAR_FIELD ||
            inputs[1] >= SNARK_SCALAR_FIELD ||
            inputs[2] >= SNARK_SCALAR_FIELD ||
            inputs[3] >= SNARK_SCALAR_FIELD ||
            inputs[4] >= SNARK_SCALAR_FIELD
        ) {
            revert ValueGreaterThanSnarkScalarField();
        }
        return PoseidonT6.hash(inputs);
    }

    function hasherUnsafe(uint256[5] memory inputs) internal pure returns (uint256) {
        return PoseidonT6.hash(inputs);
    }

    function init(QuinaryIMTData storage self, uint256 depth, uint256 zero) public {
        if (zero >= SNARK_SCALAR_FIELD) {
            revert ValueGreaterThanSnarkScalarField();
        }
        InternalQuinaryIMT._init(self, depth, zero, hasherUnsafe);
    }

    function insert(QuinaryIMTData storage self, uint256 leaf) public {
        if (leaf >= SNARK_SCALAR_FIELD) {
            revert ValueGreaterThanSnarkScalarField();
        }
        InternalQuinaryIMT._insert(self, leaf, hasherUnsafe);
    }

    function update(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256 newLeaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) public {
        if (leaf >= SNARK_SCALAR_FIELD || newLeaf >= SNARK_SCALAR_FIELD) {
            revert ValueGreaterThanSnarkScalarField();
        }
        InternalQuinaryIMT._update(self, leaf, newLeaf, proofSiblings, proofPathIndices, hasher);
    }

    function remove(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) public {
        if (leaf >= SNARK_SCALAR_FIELD) {
            revert ValueGreaterThanSnarkScalarField();
        }
        InternalQuinaryIMT._remove(self, leaf, proofSiblings, proofPathIndices, hasher);
    }

    function verify(
        QuinaryIMTData storage self,
        uint256 leaf,
        uint256[4][] calldata proofSiblings,
        uint8[] calldata proofPathIndices
    ) private view returns (bool) {
        if (leaf >= SNARK_SCALAR_FIELD) {
            revert ValueGreaterThanSnarkScalarField();
        }
        return InternalQuinaryIMT._verify(self, leaf, proofSiblings, proofPathIndices, hasher);
    }
}
