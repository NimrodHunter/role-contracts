pragma solidity ^0.4.21;

import "zeppelin-solidity/contracts/ownership/rbac/Roles.sol";
import "./BytesToUint256.sol";

/**
 * @title RBAC (Role-Based Access Control)
 * @author Matt Condon (@Shrugs)
 * @dev Stores and provides setters and getters for roles and addresses.
 * @dev Supports unlimited numbers of roles and addresses.
 * @dev See //contracts/mocks/RBACMock.sol for an example of usage.
 * This RBAC method uses uint256s to key roles. It may be beneficial
 *  for you to write your own implementation of this interface using Enums or similar.
 * It's also recommended that you define constants in the contract, like ROLE_ADMIN below,
 *  to avoid typos.
 */
contract RBAC {
    using Roles for Roles.Role;
    using BytesToUint256 for bytes;

    enum Users {ADMIN, PLATFORM ,ISSUER, TARDER}

    mapping (uint256 => Roles.Role) private roles;

    event RoleAdded(address addr, uint256 rolNumber);
    event RoleRemoved(address addr, uint256 rolNumber);

    /**
     * @dev reverts if addr does not have role
     * @param addr address
     * @param rolNumber the name of the role
     * // reverts
     */
    function checkRole(address addr, uint256 rolNumber) view public {
        roles[rolNumber].check(addr);
    }

    /**
     * @dev determine if addr has role
     * @param addr address
     * @param rolNumber the name of the role
     * @return bool
     */
    function hasRole(address addr, uint256 rolNumber) view public returns (bool) {
        return roles[rolNumber].has(addr);
    }

    /**
     * @dev add a role to an address
     * @param addr address
     * @param rolNumber the name of the role
     */
    function addRole(address addr, uint256 rolNumber)
      internal
    {
        roles[rolNumber].add(addr);
        emit RoleAdded(addr, rolNumber);
    }

    /**
     * @dev remove a role from an address
     * @param addr address
     * @param rolNumber the name of the role
     */
    function removeRole(address addr, uint256 rolNumber)
      internal
    {
        roles[rolNumber].remove(addr);
        emit RoleRemoved(addr, rolNumber);
    }

    /**
     * @dev modifier to scope access to a single role (uses msg.sender as addr)
     * @param rolNumber the name of the role
     * // reverts
     */
    modifier onlyRole(uint256 rolNumber)
    {
        checkRole(msg.sender, rolNumber);
        _;
    }

    /**
     * @dev modifier to scope access to a set of roles (uses msg.sender as addr)
     * @param rolNumbers the names of the roles to scope access to
     * // reverts
     */
    modifier onlyRoles(bytes rolNumbers) {
        bool hasAnyRole = false;
        for (uint256 i = 0; i < rolNumbers.length; i++) {
            if (hasRole(msg.sender, rolNumbers.toUint(i))) {
                hasAnyRole = true;
                break;
            }
        }
        require(hasAnyRole);
        _;
    }
}