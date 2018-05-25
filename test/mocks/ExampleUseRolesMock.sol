pragma solidity 0.4.23;

import '../../contracts/UseRoles.sol';

contract ExampleUseRolesMock is UseRoles {
    bool public traderCallCounter;
    bool public issuerCallCounter;
    bool public openCallCounter;

    constructor(address rolesContract)
        public 
        UseRoles(rolesContract)
    {}

    function traderCall() public onlyRoles(hex"0b") {
        traderCallCounter = true;
    }

    function issuerCall() public onlyRoles(hex"07") {
        issuerCallCounter = true;
    }

    function openCall() public onlyRoles(hex"0f") {
        openCallCounter = true;
    }
    
}