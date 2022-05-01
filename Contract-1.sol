// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

contract invoice{

    mapping(string => mapping(uint => task)) public show_invoice;

    uint256 count = 0;
    uint256 id;


    struct task{
        string SellerPAN;
        uint256 Invoice_Amount;
        string Invoice_Date;
    }


    enum Statuses { success, unpayed }
    Statuses currentStatus;


    constructor() public{
        currentStatus = Statuses.unpayed;
    }


    function Enter_data(string memory _BuyerPAN, uint256 _id, string memory _SellerPAN, uint256 _Invoice_Amount, string memory _Invoice_Date) public{
        show_invoice[_BuyerPAN][_id] = task(_SellerPAN , _Invoice_Amount ,_Invoice_Date);
        currentStatus = Statuses.success;
        count++;
        id=_id;
    }


    function status(uint256 _id1) view public returns(string memory){
        for (uint256 i = 0; i < count; i++) { 
            if (currentStatus == Statuses.success) {
                if (_id1 == id){
                    return "payed";
                }
                else{
                    return "unpayed";
                }
            }
            else{
                return "unpayed";
            }
        }
    }
}
