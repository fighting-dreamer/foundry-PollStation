// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {PollStation} from "../src/PollStation.sol";

contract PollStationTest is Test {
    PollStation public ps;
    address[] public candidates;
    address public voter1 = address(0x1);
    address public voter2 = address(0x2);

    address public candidate1 = makeAddr("candidate1");
    address public candidate2 = makeAddr("candidate2");

    function setUp() public {
        candidates.push(candidate1);
        candidates.push(candidate2);
        ps = new PollStation(candidates);
    }

    function test_CastVote() public {
        vm.prank(voter1);
        ps.castVote(candidate1);

        assertEq(ps.voteCount(candidate1), 1, "vote count for candidate1 should be 1");
        assertEq(ps.voteMap(voter1), candidate1, "voter1 should have voted for candidate1");
        assertEq(ps.winner(), candidate1, "winner should be candidate1");
    }

    function test_Fail_CastVoteTwice() public {
        vm.prank(voter1);
        ps.castVote(candidate1);

        vm.expectRevert("Voter already voted");
        vm.prank(voter1);
        ps.castVote(candidate2);
    }
    
    function test_TwoVoters() public {
        vm.prank(voter1);
        ps.castVote(candidate1);

        vm.prank(voter2);
        ps.castVote(candidate2);
    }

    function test_GasCostForMultipleVotes() public {
        uint256 gasBefore;
        uint256 gasAfter;

        // Vote 1: voter1 votes for candidate1.
        // This is the most expensive: first vote for candidate1 AND sets a new winner.
        gasBefore = gasleft();
        vm.prank(voter1);
        ps.castVote(candidate1);
        gasAfter = gasleft();
        console.log("Gas used for 1st vote (existing candidate, new winner):", gasBefore - gasAfter);

        // Vote 2: voter2 votes for candidate1.
        // Cheaper: candidate1 already has votes, and the winner doesn't change.
        address voter2 = makeAddr("voter2");
        gasBefore = gasleft();
        vm.prank(voter2);
        ps.castVote(candidate1);
        gasAfter = gasleft();
        console.log("Gas used for 2nd vote (existing candidate, same winner):", gasBefore - gasAfter);

        // Voter 3: vote for candidate2.
        address voter3 = makeAddr("voter3");
        gasBefore = gasleft();
        vm.prank(voter3);
        ps.castVote(candidate2);
        gasAfter = gasleft();
        console.log("Gas used for 3rd vote (existing candidate, same winner):", gasBefore - gasAfter);

        // Voter 4: vote for candidate2.
        address voter4 = makeAddr("voter4");
        gasBefore = gasleft();
        vm.prank(voter4);
        ps.castVote(candidate2);
        gasAfter = gasleft();
        console.log("Gas used for 4th vote (existing candidate, same winner):", gasBefore - gasAfter);

        // Voter 5: vote for candidate2, new winner.
        address voter5 = makeAddr("voter5");
        gasBefore = gasleft();
        vm.prank(voter5);
        ps.castVote(candidate2);
        gasAfter = gasleft();
        console.log("Gas used for 5th vote (existing candidate, new winner):", gasBefore - gasAfter);
        
        // Voter 5: vote for candidate1, same winner.
        address voter6 = makeAddr("voter6");
        gasBefore = gasleft();
        vm.prank(voter6);
        ps.castVote(candidate1);
        gasAfter = gasleft();
        console.log("Gas used for 5th vote (existing candidate, new winner):", gasBefore - gasAfter);
        
    }

    function test_Fail_VoteForNonCandidate() public {
        vm.expectRevert("Candidate not exist");
        ps.castVote(makeAddr("non_candidate"));
    }
}
