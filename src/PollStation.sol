// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract PollStation {
    // store candidates
    mapping(address => bool) public candidatesMap;
    // store who have caseted vote
    // store the voted candidate for given address
    mapping(address => address) public voteMap;
    // store counts of votes for each candidate
    mapping(address => uint256) public voteCount;

    uint256 winnerVoteCount;
    address public winner;

    event AddedCandidate(address indexed candidate);
    event Voted(address indexed voter, address indexed candidate);

    constructor(address[] memory _candidates) {
        for (uint i = 0; i < _candidates.length; i++) {
            if (isValidAddress(_candidates[i])) {
                candidatesMap[_candidates[i]] = true;
                emit AddedCandidate(_candidates[i]);
            }
        }
    }

    /**
     * @dev Checks if the given address is not the zero address.
     */
    function isValidAddress(address _addr) internal pure returns (bool) {
        return _addr != address(0);
    }

    function castVote(address _candidate) public returns (bool) {
        require(candidatesMap[_candidate], "Candidate not exist");
        require(voteMap[msg.sender] == address(0), "Voter already voted");

        voteMap[msg.sender] = _candidate;
        voteCount[_candidate]++;
        emit Voted(msg.sender, _candidate);

        if(voteCount[_candidate] > winnerVoteCount) {
            winner = _candidate;
            winnerVoteCount = voteCount[_candidate];
        }

        return true;
    }


}
