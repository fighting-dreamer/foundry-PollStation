// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PollStation} from "../src/PollStation.sol";

contract PollStationScript is Script {
    PollStation public ps;

    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("WALLET_PRIVATE_KEY");
        address addr = vm.addr(privateKey);
        console.log("address", addr);
        console.log("Chain ID:", block.chainid);
        vm.startBroadcast(privateKey);

        address[] memory candidates = new address[](2);
        candidates[0] = 0x90F79bf6EB2c4f870365E785982E1f101E93b906; // test address 3 in anvil
        candidates[1] = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65; // test address 4 in anvil

        ps = new PollStation(candidates);
        vm.stopBroadcast();
    }
}
