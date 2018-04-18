pragma solidity ^0.4.21;

import "./PlatformRoles.sol";

contract UseRoles {
    PlatformRoles private rolesContract;

    function UseRoles(address _rolesContract) public {
        rolesContract = PlatformRoles(_rolesContract);
    }

    function changeRolesContract(address _rolesContract) public onlyRole(0) {
        rolesContract = PlatformRoles(_rolesContract);
    }

    /**
     * @dev modifier to scope access to a single role (uses msg.sender as addr)
     * @param rolNumber the name of the role
     * // reverts
     */
    modifier onlyRole(uint256 rolNumber)
    {
        rolesContract.checkRole(msg.sender, rolNumber);
        _;
    }

    /**
     * @dev modifier to scope access to a set of roles (uses msg.sender as addr)
     * @param roleNumbers the names of the roles to scope access to
     * // reverts
     */
    modifier onlyRoles(bytes roleNumbers) {
        bool hasAnyRole = false;
        for (uint256 i = 0; i < roleNumbers.length; i++) {
            if (rolesContract.hasRole(msg.sender, uint(roleNumbers[i]))) {
                hasAnyRole = true;
                break;
            }
        }
        require(hasAnyRole);
        _;
    }

}