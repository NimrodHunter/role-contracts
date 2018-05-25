pragma solidity ^0.4.23;

contract Roles {

    mapping (address => bytes32) private roles;

    event RoleSetted(address user, bytes32 rolNumber);

    function hasRoles(address user, bytes32 rolNumber) public view returns (bool) {
        return ((roles[user] & rolNumber) > 0 );
    }

    function setRole(address user, bytes32 rolNumber) internal {
        roles[user] = rolNumber;
        emit RoleSetted(user, rolNumber);
    }

    modifier onlyRoles(bytes32 rolNumber) {
        require(hasRoles(msg.sender, rolNumber));
        _;
    }
}