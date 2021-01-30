//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

contract PiggyBank {
    string public name;
    address payable owner;
    mapping(address => Saving) savings;

    struct Saving {
        uint amount;
        uint numtimes;
    }

    constructor(string memory _name) public {
        name = _name;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function deposit() public payable {
        Saving storage saving = savings[msg.sender];
        saving.amount += msg.value;
        saving.numtimes += 1;
        emit Deposit(msg.sender, msg.value); 
    }

    event Deposit(address indexed _from, uint value);

    // function getBalance() public view returns(uint) {
    //     return savings[msg.sender].amount;
    // }

    function getOwner() public view returns(address){
        return owner;
    }

    function changeOwner(address payable _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    // pending for test
    function withdraw() public onlyOwner {
        uint amount = savings[msg.sender].amount;
        savings[msg.sender].amount = 0;
        msg.sender.transfer(amount);
    }

    // pending for test
    function destroy() public onlyOwner{
        selfdestruct(owner);
    }   

}