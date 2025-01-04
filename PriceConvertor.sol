//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConvertor{
   function getPrice() internal view returns(uint256){//returns eth in usd
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (, int256 price,,, )= priceFeed.latestRoundData();
         return uint256(price * 1e10);
     }
     function getConversionRate(uint256 ethAmount) internal view returns(uint256){
          uint256 ethPrice = getPrice();
         uint256 ethAmountinusd = (ethPrice *ethAmount) / 1e18;
         return ethAmountinusd;

     }
     function getVersion() public view returns (uint256) {
    return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
}
}