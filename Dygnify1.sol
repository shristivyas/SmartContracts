// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

contract invoice{
    mapping(string => task) public show_invoice;

    struct task{
        string SellerPAN;
        uint256 Invoice_Amount;
        string Invoice_Date;
    }

    enum Statuses { success, unpayed }
    Statuses currentStatus;

    address payable public owner;

    constructor() public{
        owner=msg.sender;
        currentStatus = Statuses.unpayed;
    }

    modifier whileunpayed{
        require(currentStatus == Statuses.unpayed,"success");
        _;
    }
    

    function Enter_data(string memory _BuyerPAN, string memory _SellerPAN, uint256 _Invoice_Amount, string memory _Invoice_Date) public{
        show_invoice[_BuyerPAN] = task(_SellerPAN , _Invoice_Amount ,_Invoice_Date);
        currentStatus = Statuses.success;
    }

    modifier costs(uint _Amount){
        require(msg.value >=_Amount ,"not anough");
        _;
    }

    receive() external payable whileunpayed costs(2 ether){
        currentStatus = Statuses.success;
        owner.transfer(msg.value);
    }


}
