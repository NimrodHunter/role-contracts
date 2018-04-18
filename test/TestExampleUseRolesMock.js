import expectThrow from './helpers/expectThrow';

const PlatformRoles = artifacts.require('PlatformRoles');
const ExampleUseRolesMock = artifacts.require('ExampleUseRolesMock');

contract('Use Platform Roles', (accounts) => {

  let rolesContract;
  let useRoleContract;
  let platform = accounts[1];
  let trader = accounts[2];
  let issuer = accounts[3];
  let traderIssuer = accounts[4];
  const Roles = {
    ADMIN: 0,
    PLATFORM: 1,
    ISSUER: 2,
    TRADER: 3,
  };

  beforeEach(async () => {
    rolesContract = await PlatformRoles.new(platform);
    await rolesContract.adminAddRole(trader, Roles.TRADER);
    await rolesContract.adminAddRole(issuer, Roles.ISSUER);
    await rolesContract.adminAddRole(traderIssuer, Roles.ISSUER);
    await rolesContract.adminAddRole(trader, Roles.TRADER);
    useRoleContract = await ExampleUseRolesMock.new(rolesContract.address);
  });

  it('should call a trader function', async () => {

    await useRoleContract.traderCall({from: trader});
    const traderCall = await useRoleContract.traderCallCounter.call();
    assert(traderCall, true)

  });

  it('should call a issuer function', async () => {

    await useRoleContract.issuerCall({from: issuer});
    const issuerCall = await useRoleContract.issuerCallCounter.call();
    assert(issuerCall, true)

  });

  it('should call a open function from issuer', async () => {

    await useRoleContract.openCall({from: issuer});
    const openCall = await useRoleContract.openCallCounter.call();
    assert(openCall, true)

  });

  it('should call a open function from trader', async () => {

    await useRoleContract.openCall({from: trader});
    const openCall = await useRoleContract.openCallCounter.call();
    assert(openCall, true)

  });


});