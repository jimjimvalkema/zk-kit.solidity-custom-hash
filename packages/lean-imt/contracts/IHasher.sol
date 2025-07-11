// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IHasher {
    function hash(uint[2] memory) external view returns (uint);
}
