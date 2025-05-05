// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../sfc/SFC.sol";

contract UnitTestSFC is SFC {
    function minSelfStake() public pure override returns (uint256) {
        // Add override here
        // 0.3175000 NEC
        return 0.3175000 * 1e18;
    }

    uint256 public time;

    function rebaseTime() external {
        time = block.timestamp;
    }

    function advanceTime(uint256 diff) external {
        time += diff;
    }

    function _now() internal view override returns (uint256) {
        return time;
    }

    function getTime() external view returns (uint256) {
        return time;
    }

    function getBlockTime() external view returns (uint256) {
        return SFC._now();
    }

    function highestLockupEpoch(
        address delegator,
        uint256 validatorID
    ) external view returns (uint256) {
        return _highestLockupEpoch(delegator, validatorID);
    }

    bool public allowedNonNodeCalls;

    function enableNonNodeCalls() external {
        allowedNonNodeCalls = true;
    }

    function disableNonNodeCalls() external {
        allowedNonNodeCalls = false;
    }

    function isNode(address addr) internal view override returns (bool) {
        if (allowedNonNodeCalls) {
            return true;
        }
        return SFC.isNode(addr);
    }
}
