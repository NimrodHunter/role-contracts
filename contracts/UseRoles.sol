pragma solidity ^0.4.23;

import "./PlatformRoles.sol";

contract UseRoles {
    PlatformRoles private rolesContract;

    constructor(address _rolesContract) public {
        rolesContract = PlatformRoles(_rolesContract);
    }

    function changeRolesContract(address _rolesContract) public onlyRoles(hex"03") {
        rolesContract = PlatformRoles(_rolesContract);
    }

    modifier onlyRoles(bytes32 rolNumber) {
        require(rolesContract.hasRoles(msg.sender, rolNumber), "sender doesn't fit the role");
        _;
    }
}