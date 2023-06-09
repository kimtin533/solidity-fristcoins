// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Firstcoin{
    address public minter;
    mapping (address => uint) public balances;

    event sent(address from, address to, uint amount);

    modifier onlyMinter{
        require(msg.sender == minter);
        _;
    }
    modifier checkMint(uint amount){
        require(amount < 1e60);
        _;
    }
    modifier checkBalance(uint amount){
        require(amount <= balances[msg.sender],"khong du tien dau ku");
        _;
    }

    constructor (){
        minter = msg.sender;
    } 

    function mint(address receiver, uint amount)public onlyMinter checkMint(amount)  {

        balances[receiver] += amount;
    }

    function send(address receiver, uint amount)public checkBalance(amount){
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent( msg.sender, receiver, amount);
    }


}