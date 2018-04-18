pragma solidity 0.4.21;

import '../../contracts/UseRoles.sol';

contract ExampleUseRolesMock is UseRoles {
    bool public traderCallCounter;
    bool public issuerCallCounter;
    bool public openCallCounter;

    function ExampleUseRolesMock(address rolesContract)
        public 
        UseRoles(rolesContract)
    {}

    function traderCall() public onlyRole(3) {
        traderCallCounter = true;
    }

    function issuerCall() public onlyRole(2) {
        issuerCallCounter = true;
    }

    function openCall() public onlyRoles(hex"0203") {
        openCallCounter = true;
    }
    
}