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
/*

clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t


/*******************************************************************************

	Bitcoin Futures Garch and Asymmetric Garch Models

*******************************************************************************/

c
	* Asymmetric relationship not found like Baur 2012 had found in gold
	
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z) vce(robust)
	* Good news statistically sigificant but not statistically different than bad news
test BC_Ft_GN_Z = BC_Ft_BN_Z
		
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend) vce(robust)
	* With google trends which I am using as a speculative investment proxy
	* Found bad news and speculative investment proxy statistically significant 
test BC_Ft_GN_Z = BC_Ft_BN_Z
	* Asymmetric statistically significant; Good news increases
	
	
/*******************************************************************************

	Bitcoin Volatility Effects Safe-haven attribute and

*******************************************************************************/

*arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(VIX_Close) vce(robust)
	*Cannot compile for larger data set

arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend VIX_Close) vce(robust)
	* After controlling for Good news / Bad News and Spec Inv proxy (Google Trends), VIX not related
test BC_Ft_GN_Z=BC_Ft_BN_Z
	* Statistically different at 10% level
	

/*******************************************************************************

	S&P 500 Garch Models

*******************************************************************************/

arch SP500_Rtn, ar(1) arch(1) garch(1) het(SP500_Vol)
	* Volume increases volatility of the returns
	
arch SP500_Rtn, ar(1) arch(1) garch(1) het(SP500_GN_Z SP500_BN_Z)
	* Good News decreases the volatility of S&P 500 and Bad news increases
test SP500_GN_Z=SP500_BN_Z
	* Asymmetric volatility to good news / bad news statistically different
	* Good news decreases volatility and bad news increases
	
	
/*******************************************************************************

	Gold Index and Bullion Garch Models
	
*******************************************************************************/


arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_Vol)  vce(robust)
	* Volume of gold statisticall significant - increases volatility

arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_GN_Z SPDR_BN_Z)  vce(robust)
	* Both significantly positive but really small
test SPDR_GN_Z = SPDR_BN_Z
	* not statistically different from each other
	
*arch SPDR_Rtn, ar(1) arch(1) garch(1) tarch(1) vce(robust)
	* London Gold Bullion returns
	* Typical asymmetric garch does not compile
	
	
/*************************** 0 - 60 Day Dataset ***************************************/




clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

drop if t>60
	* Bitcoin Futures / Vix relationship stable at 60 days ~ 6 weeks of market data


/*******************************************************************************

	Safe-Haven Aspect - Bitcoin / Marker relationship under turmoil
	
*******************************************************************************/


	
*arch BC_Ft_Rtn, ar(1) arch(1) garch(1) tarch(1) vce(robust)	
	* Cannot compile traditional asymmetric garch model
	
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(VIX_Close) vce(robust)
	* Vix found to be negative at 7% level
test VIX_Close
	* Vix different from zero at 7% level
	
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend VIX_Close) vce(robust)
	* Good news found to be positive but not statistically different from Bad news
	* VIX controlling for speculative investment impacts and bad news impacts-  not significant
test BC_Ft_GN_Z = BC_Ft_BN_Z
	* Good news found to be positive but not statistically different from Bad news

/*******************************************************************************

	Gold Index and Bullion Garch Models
	
*******************************************************************************/


*arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_Vol)
	* Does not compile

*arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_GN_Z SPDR_BN_Z)
	* Does not compile
		
*arch Gold_Rtn, ar(1) arch(1) garch(1) tarch(1)
	* London Gold Bullion returns
	* Typical asymmetric garch does not compile
	

/*************************** 60 - 191 Day Dataset ***************************************/


clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

drop if t<=60
	* Bitcoin Futures / Vix relationship stable at 60 days ~ 6 weeks of market data


/*******************************************************************************

	Safe-Haven Aspect - "Normal" Market conditions
	
*******************************************************************************/

arch BC_Ft_Rtn, ar(1) arch(1) garch(1) tarch(1) het(Goog_Trend VIX_Close) vce(robust)	
	* Asymmetric effect found to be positive and statistically significant
	
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(VIX_Close) vce(robust)
	* Vix found to be negative at 7% level
test VIX_Close
	* Vix different from zero at 7% level
	
*arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend VIX_Close) vce(robust)
	* Does not compile


/*******************************************************************************

	Gold Index and Bullion Garch Models
	
*******************************************************************************/


arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_Vol)
	* Volume of gold statisticall significant - increases volatility

arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_GN_Z SPDR_BN_Z)
	* Both significantly positive but really small * same relationship 
test SPDR_GN_Z = SPDR_BN_Z
	* not statistically different from each other
	
*arch Gold_Rtn, ar(1) arch(1) garch(1) tarch(1)
	* London Gold Bullion returns
	* Typical asymmetric garch does not compile
	

/*************************** 0 - 100 Day Dataset ***************************************/


clear
import excel using "C:\Users\allen\Desktop\School\ECON 6902\First_Presentation\Bitcoin Futures Data_Master.xlsx", sheet("Master_Data") firstrow
gen t = _n
tsset t

drop if t<=100


/*******************************************************************************

	Safe-Haven Aspect - "Normal" Market conditions
	
*******************************************************************************/

arch BC_Ft_Rtn, ar(1) arch(1) garch(1) tarch(1) het(Goog_Trend VIX_Close) vce(robust)	
	* Asymmetric effect found to be positive and statistically significant
	
arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(VIX_Close) vce(robust)
	* Vix found to be negative at 7% level
test VIX_Close
	* Vix different from zero at 7% level
	
*arch BC_Ft_Rtn, ar(1) arch(1) garch(1) het(BC_Ft_GN_Z BC_Ft_BN_Z Goog_Trend VIX_Close) vce(robust)
	* Does not compile


/*******************************************************************************

	Gold Index and Bullion Garch Models
	
*******************************************************************************/


arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_Vol)
	* Volume of gold statisticall significant - increases volatility

arch SPDR_Rtn, ar(1) arch(1) garch(1) het(SPDR_GN_Z SPDR_BN_Z)
	* Both significantly positive but really small * same relationship 
test SPDR_GN_Z = SPDR_BN_Z
	* not statistically different from each other
	
*arch Gold_Rtn, ar(1) arch(1) garch(1) tarch(1)
	* London Gold Bullion returns
	* Typical asymmetric garch does not compile
	




