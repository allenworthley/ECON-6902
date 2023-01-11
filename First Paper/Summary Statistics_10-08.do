/****************************************

	Manning Worthley
	ECON 6902
	Is Bitcoin a Safe-Haven?

******************************************/

/*	Variable names:

BC_Ft_Close		- CBOE Bitcoin future price data close price
BC_Ft_High
BC_Ft_Low
BC_Ft_Vol		- Bitcoin Futures Volume
BC_Ft_Rtn		- Returns of bitcoin future data
VIX_Close		- VIX of S&P 500
VIX_High
VIX_Low
SP500_Close		- S&P 500 etf index
SP500_High	
SP500_Low
SP500_Vol		- S&P Volume
SP500_Rtn		- Returns of S&P 500 etf index
SPDR_Close		- Gold Index ETF
SPDR_High		
SPDR_Low
SPDR_Vol		- SPDR Volume
SPDR_Rtn		- Gold ETF Returns
GoldVIX_Close	- Gold ETF (SPDR) Volatility index	
GoldVIX_High
GoldVIX_Low
Goog_Trend		- weighted views per day; Substitute for Bitcoin Volume
BC_Close		- CoinDesk Index close
BC_High				
BC_Low	
BC_Vol			- Goog_Trend proxy for volume
BC_Rtn			- Bitcoin Return
Gold_Rtn		- London gold bullion price return

Goog_Trend 		- Normalized google search data; 100 representing highest daily view and 1 representing lowest

BC_Ft_GN_Z		- Bitcoin Futures Good news volume 
BC_Ft_BN_Z		- Bitcoin FuturesBad news volume 
SP500_GN_Z		- S&P Good news volume 
SP500_BN_Z		- S&P Bad news volume
SPDR_GN_Z		- Gold ETF Good news volume
SPDR_BN_Z		- Gold ETF Bad news volume
BC_GN_Z			- Bitcoin Good news volume
BC_BN_Z			- Bitcoin Bad news volume

*/

/*************************** Full Data Set ************************************/


clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

sum BC_Ft_Rtn BC_Ft_Vol BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend SP500_Rtn SP500_Vol SP500_GN_Z SP500_BN_Z VIX_Close SPDR_Rtn SPDR_Vol SPDR_GN_Z SPDR_BN_Z

	
/*************************** 0 - 60 Day Dataset ***************************************/


clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

drop if t>60
	* Bitcoin Futures / Vix relationship stable at 60 days ~ 6 weeks of market data
	
sum BC_Ft_Rtn BC_Ft_Vol BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend SP500_Rtn SP500_Vol SP500_GN_Z SP500_BN_Z VIX_Close SPDR_Rtn SPDR_Vol SPDR_GN_Z SPDR_BN_Z


/*************************** 60 - 191 Day Dataset ***************************************/


clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

drop if t<=60
	* Bitcoin Futures / Vix relationship stable at 60 days ~ 6 weeks of market data

sum BC_Ft_Rtn BC_Ft_Vol BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend SP500_Rtn SP500_Vol SP500_GN_Z SP500_BN_Z VIX_Close SPDR_Rtn SPDR_Vol SPDR_GN_Z SPDR_BN_Z

	
	
	
	
	
	
	