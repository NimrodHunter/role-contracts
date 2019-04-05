# Roles

[![Coverage Status](https://coveralls.io/repos/github/NimrodHunter/role-contracts/badge.svg)](https://coveralls.io/github/NimrodHunter/role-contracts)

Manage access to other contract functions by roles.

## Overview
The general idea is manage the access to functions of different contracts by roles.

users can play many roles, that roles will give them access to different contracts functions.

The contracts functions can be set to only permit access to only some roles or can be public.

Each time, that one of this function are called, will be verified if the msg.sender have the roles to access to this function, just in case that the function  it is only callable by some roles.

## Structure

### Owner

Owner is the upper level of hierarchy into the roles, as default it is the msg.sender when the roles contract is created, can access to every function.

### Authority

Authority is a smart contract that implement canCall function, this function is in charge to veryfy if the msg.sender can access to the function. Authority have the same level of hierarchy that the owner.

### Root

Root can access to every function, have the same level of hierarchy that the owner.

### PublicCapability

When a function it is set as PublicCapabilitty, can be access be any address.

### Roles

Roles are defined by uint8, this numbers are order in a bitwise categorizathion, like on/off switch, if the bit n is 1, its means that the user have that role. if it is set the uint8 equal to 6 as input of setUserRole function, its means that the bit 6, counting right to left will change, if enable it is true will be 1, else will be 0.

## Analysis

- [surya](https://github.com/NimrodHunter/Debt-Package-Contracts/blob/master/analysis/surya_roles_report.md)

- [mythril](https://github.com/NimrodHunter/Debt-Package-Contracts/blob/master/analysis/mythril_roles_report.md)


