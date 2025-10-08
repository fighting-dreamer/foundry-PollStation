Compiling 1 files with Solc 0.8.28
Solc 0.8.28 finished in 499.19ms
Compiler run successful with warnings:
Warning (2519): This declaration shadows an existing declaration.
  --> test/PollStation.t.sol:62:9:
   |
62 |         address voter2 = makeAddr("voter2");
   |         ^^^^^^^^^^^^^^
Note: The shadowed declaration is here:
  --> test/PollStation.t.sol:11:5:
   |
11 |     address public voter2 = address(0x2);
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Ran 5 tests for test/PollStation.t.sol:PollStationTest
[PASS] test_CastVote() (gas: 134056)
[PASS] test_Fail_CastVoteTwice() (gas: 159128)
[PASS] test_Fail_VoteForNonCandidate() (gas: 35203)
[PASS] test_GasCostForMultipleVotes() (gas: 468309)
Logs:
  Gas used for 1st vote (existing candidate, new winner): 128070
  Gas used for 2nd vote (existing candidate, same winner): 62826
  Gas used for 3rd vote (existing candidate, same winner): 76558
  Gas used for 4th vote (existing candidate, same winner): 57458
  Gas used for 5th vote (existing candidate, new winner): 65626
  Gas used for 5th vote (existing candidate, new winner): 57458

[PASS] test_TwoVoters() (gas: 206985)
Suite result: ok. 5 passed; 0 failed; 0 skipped; finished in 2.66ms (3.59ms CPU time)

╭------------------------------------------+-----------------+-------+--------+--------+---------╮
| src/PollStation.sol:PollStation Contract |                 |       |        |        |         |
+================================================================================================+
| Deployment Cost                          | Deployment Size |       |        |        |         |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| 540375                                   | 3052            |       |        |        |         |
|------------------------------------------+-----------------+-------+--------+--------+---------|
|                                          |                 |       |        |        |         |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| Function Name                            | Min             | Avg   | Median | Max    | # Calls |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| castVote                                 | 24382           | 74639 | 68539  | 115373 | 12      |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| voteCount                                | 802             | 802   | 802    | 802    | 1       |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| voteMap                                  | 919             | 919   | 919    | 919    | 1       |
|------------------------------------------+-----------------+-------+--------+--------+---------|
| winner                                   | 574             | 574   | 574    | 574    | 1       |
╰------------------------------------------+-----------------+-------+--------+--------+---------╯


Ran 1 test suite in 3.55ms (2.66ms CPU time): 5 tests passed, 0 failed, 0 skipped (5 total tests)
