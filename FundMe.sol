//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";
contract FundMe{
    using PriceConvertor for uint256;
    error NotOwner();
    uint256 public constant MIN_USD= 5;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;
    constructor(){
      i_owner == msg.sender;
    }
     function fund() public payable{
        msg.value.getConversionRate();
        //require(getConversionRate(msg.value)>=minusd,"Didnt send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
     }
     modifier onlyOwner(){
       //require(msg.sender == i_owner,"NOt the Owner");
       if(msg.sender !=i_owner) revert NotOwner();
       _;
     }

     function withdraw() public onlyOwner {
       for(uint fundersIndex = 0;fundersIndex< funders.length ;fundersIndex++){
           address funder = funders[fundersIndex];
           addressToAmountFunded[funder]=0;

       }
       funders = new address[](0);
       (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
     }

     receive() external payable{
      fund();
     }
     fallback() external payable{
      fund();
     }
}