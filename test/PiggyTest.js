const PiggyBank = artifacts.require('PiggyBank');

contract('Piggy Bank', (accounts) => {

    let piggyBank;

    before(async () => {
        piggyBank = await PiggyBank.new('Mario');
    })

    it('Has a name', async () => {
        const name = await piggyBank.name.call();
        assert.equal(name, 'Mario');
    });

    it('Should put something ether', async() => {
        await piggyBank.deposit({ from: accounts[0], value: web3.utils.toWei('2')});    
    });

    it('Should change owner', async () => {
        const owner = await piggyBank.getOwner();
        await piggyBank.changeOwner(accounts[1]);
        const newOwner = await piggyBank.getOwner();
        assert.notEqual(owner, newOwner);
    });

    it('Should withdraw' , async () => {
        const owner = await piggyBank.getOwner();
        await piggyBank.withdraw({from: owner});
    });

    it('not Should withdraw' , async () => {
        const owner = await piggyBank.getOwner();
        await piggyBank.withdraw({from: accounts[2]});
    });

})
