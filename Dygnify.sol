// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

contract invoice{
    mapping(string => task) public show_invoice;

    struct task{
        string SellerPAN;
        string Invoice_Amount;
        string Invoice_Date;
    }

    enum Statuses { success, unpayed }
    Statuses currentStatus;

    address owner;

    constructor() public{
        owner=msg.sender;
        currentStatus = Statuses.unpayed;
    }

    modifier whileunpayed{
        require(currentStatus == Statuses.unpayed,"success");
        _;
    }
    

    function Enter_data(string memory _BuyerPAN, string memory _SellerPAN, string memory _Invoice_Amount, string memory _Invoice_Date) whileunpayed public{
        currentStatus = Statuses.success;
        show_invoice[_BuyerPAN] = task(_SellerPAN , _Invoice_Amount ,_Invoice_Date);
    }


}
