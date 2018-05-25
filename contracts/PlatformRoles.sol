pragma solidity ^0.4.23;

import "./Roles.sol";

contract PlatformRoles is Roles {

    bytes32 private constant ADMIN = hex"01";

    bytes32 private constant PLATFORM = hex"02";
    
    constructor(address admin, address platform)
        public
    {
        setRole(admin, ADMIN);
        setRole(platform, PLATFORM);
    }
    
    function platformSetRole(address user, bytes32 roleNumber)
        onlyRoles(hex"03")
        public
    {
        if(hasRoles(msg.sender, PLATFORM)) {
            require(roleNumber & hex"03" == 0);
        }
        setRole(user, roleNumber);
    }
}