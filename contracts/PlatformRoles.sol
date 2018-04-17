pragma solidity ^0.4.21;

import "./RBAC.sol";

/**
 * @title RBAC for TF platform
 * @author Anibal Eduardo (@NimrodHunter)
 * @dev It's recommended that you define constants in the contract,
 * @dev like ROLE_ADMIN below, to avoid typos.
 */
contract PlatformRoles is RBAC {

    uint256 private constant admin = uint256(Users.ADMIN);

    uint256 private constant platform = uint256(Users.PLATFORM);

    
    /**
     * @dev modifier to scope access to admins
     * // reverts
     */
    modifier onlyAdmin()
    {
        checkRole(msg.sender, admin);
        _;
    }

    modifier onlyPlatform(uint256 roleNumber)
    {
        require(roleNumber != uint256(admin) && roleNumber != uint256(platform));
        require(hasRole(msg.sender, platform) || hasRole(msg.sender, admin));
        _;
    }
    
    /**
     * @dev constructor. Sets msg.sender as admin by default
     */
    function PlatformRoles(address platfromAddress)
        public
    {
        addRole(msg.sender, admin);
        addRole(platfromAddress, platform);
    }

    /**
     * @dev add a role to an address
     * @param addr address
     * @param roleNumber the number of the role
     */
    function adminAddRole(address addr, uint256 roleNumber)
        onlyAdmin
        public
    {
        addRole(addr, roleNumber);
    }

    /**
     * @dev remove a role from an address
     * @param addr address
     * @param roleNumber the number of the rol
     */
    function adminRemoveRole(address addr, uint256 roleNumber)
        onlyAdmin
        public
    {
        removeRole(addr, roleNumber);
    }

    /**
     * @dev add a role to an address
     * @param addr address
     * @param rolNumber the name of the role
     */
    function platformAddRole(address addr, uint256 rolNumber)
        onlyPlatform(rolNumber)
        public
    {
        addRole(addr, rolNumber);
    }

    /**
     * @dev remove a role from an address
     * @param addr address
     * @param rolNumber the name of the role
     */
    function platformRemoveRole(address addr, uint256 rolNumber)
        onlyPlatform(rolNumber)
        public
    {
        removeRole(addr, rolNumber);
    }

   


}