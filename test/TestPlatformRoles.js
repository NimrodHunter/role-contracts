import expectThrow from './helpers/expectThrow';

const PlatformRoles = artifacts.require('PlatformRoles');

contract('Platform Roles', (accounts) => {

  let rolesContract;
  let platform = accounts[1];
  const Roles = {
    ADMIN: 0,
    PLATFORM: 1,
    ISSUER: 2,
    TRADER: 3,
  };

  before(async () => {
    rolesContract = await PlatformRoles.new(platform);
  });

  it('should add an user as admin', async () => {
    const admin2 = accounts[9];
    const tx = await rolesContract.adminAddRole(admin2, Roles.ADMIN);
    const isAdmin = await rolesContract.hasRole.call(admin2, Roles.ADMIN);
    assert.equal(isAdmin, true, 'should be admin');
    
    // Test event
    const logs = tx.logs[0];

    assert.equal(logs.event, 'RoleAdded');
    assert.equal(logs.args.addr, admin2);
    assert.equal(logs.args.rolNumber, Roles.ADMIN);
  });

  it('should not add an user as admin', async () => {
    const admin2 = accounts[9];

    it('platfrom should not add an user as admin from adminAddRole', async () => {
      await expectThrow(rolesContract.adminAddRole(admin2, Roles.ADMIN, {from: platform}));
    });

    it('platfrom should not add an user as admin from platformAddRole', async () => {
        await expectThrow(rolesContract.platformAddRole(admin2, Roles.ADMIN, {from: platform}));
    });

    
    
  });




});