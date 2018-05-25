import expectThrow from './helpers/expectThrow';

const PlatformRoles = artifacts.require('PlatformRoles');

contract('Platform Roles', (accounts) => {
  let rolesContract;
  let admin = accounts[0];
  let platform = accounts[1];
  const Roles = {
    ADMIN: '0x01',
    PLATFORM: '0x02',
    ISSUER: '0x04',
    TRADER: '0x08',
  };

  beforeEach(async () => {
    rolesContract = await PlatformRoles.new(admin, platform);
  });

  it('should add an user as admin', async () => {
    const admin2 = accounts[9];
    const tx = await rolesContract.platformSetRole(admin2, Roles.ADMIN);
    const isAdmin = await rolesContract.hasRoles.call(admin2, Roles.ADMIN);
    assert.equal(isAdmin, true, 'should be admin');
    
    // Test event
    const logs = tx.logs[0];

    assert.equal(logs.event, 'RoleSetted');
    assert.equal(logs.args.user, admin2);
    assert.equal(logs.args.rolNumber.substring(0,4), Roles.ADMIN);
  });

  it('should not add an user as admin', async () => {
    const admin2 = accounts[9];
    await expectThrow(rolesContract.platformSetRole(admin2, Roles.ADMIN, {from: platform}));
    
  });

});