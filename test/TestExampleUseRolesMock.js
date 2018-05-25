import expectThrow from './helpers/expectThrow';

const PlatformRoles = artifacts.require('PlatformRoles');
const ExampleUseRolesMock = artifacts.require('ExampleUseRolesMock');

contract('Use Platform Roles', (accounts) => {

  let rolesContract;
  let useRoleContract;
  let admin = accounts[0];
  let platform = accounts[1];
  let trader = accounts[2];
  let issuer = accounts[3];
  let traderIssuer = accounts[4];
  const Roles = {
    ADMIN: '0x01',
    PLATFORM: '0x02',
    ISSUER: '0x04',
    TRADER: '0x08',
  };

  beforeEach(async () => {
    rolesContract = await PlatformRoles.new(admin, platform);
    await rolesContract.platformSetRole(trader, Roles.TRADER);
    await rolesContract.platformSetRole(issuer, Roles.ISSUER);
    await rolesContract.platformSetRole(traderIssuer, Roles.ISSUER);
    await rolesContract.platformSetRole(trader, Roles.TRADER);
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