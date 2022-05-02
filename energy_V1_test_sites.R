#Developed for Trivium energy team
#Energy market data pipeline project
setwd("D:/Trivium/Trivium_Energy_Market_Data_Pipeline_Project")
library(rvest)
library(XML)
library(dplyr)
#carbon trading data====
#This doesn't work
url_carbon<-"http://www.tanjiaoyi.org.cn/k/index.html"
web_carbon<-read_html(url_carbon)
attr<-html_attrs(web_carbon)
tb<-web_carbon%>%html_nodes("")

#coal====
#This works
url_coal<-"https://www.cctd.com.cn/index.php?m=content&c=index&a=lists&catid=520"
web_coal<-read_html(url_coal)
tb_coal<-web_coal%>%html_nodes("table.datatable")%>%html_table()
tb_coal

#oil====
#This works
url_oil<-"https://data.eastmoney.com/cjsj/yjtz/default.html"
web_oil<-read_html(url_oil)
tb_oil<-web_oil%>%html_nodes("table.table-model")%>%html_table()
tb_oil

#oil site 2====
#This also works
url_oil2<-"https://oil.usd-cny.com/"
web_oil2<-read_html(url_oil2)
tb_oil2<-web_oil2%>%html_nodes("table")%>%html_table()
tb_oil2

#domestic natural gas====
#This doesn't work
url_dng<-"https://egas.cnfin.com/#/home/index"
web_dng<-read_html(url_dng)
html_attrs(web_dng)
html_text(web_dng)
tb_dng<-web_dng%>%html_nodes("div.el-table__body-wrapper.is-scrolling-none")

#international oil prices====
#Brent Crude
#site: marketwatch
#This works yay!
url_bc<-"https://www.marketwatch.com/investing/future/brn00?countrycode=uk"
web_bc<-read_html(url_bc)
tb_bc<-web_bc%>%html_nodes("div.element.element--table.overflow--table.FuturesContracts")%>%html_table()
tb_bc

#Brent Crude
#site: oilprice
#This also works
url_op<-"https://oilprice.com/oil-price-charts/46"
web_op<-read_html(url_op)
tb_op<-web_op%>%html_nodes("table.oilprices__table")%>%html_table()
tb_op

#WTI
#site: marketwatch
#This works
url_wti<-"https://www.marketwatch.com/investing/future/crude%20oil%20-%20electronic"
web_wti<-read_html(url_wti)
tb_wti<-web_wti%>%html_nodes("table.table.table--primary.align--right")%>%html_table()
tb_wti

#WTI
#site:oilprice
#This also works
url_wtiop<-"https://oilprice.com/oil-price-charts/"
web_wtiop<-read_html(url_wtiop)
tb_wtiop<-web_wtiop%>%html_nodes("table.oilprices__table")%>%html_table()
tb_wtiop

#international natural gas prices====
#This works
url_ing<-"https://www.marketwatch.com/investing/future/ng00"
web_ing<-read_html(url_ing)
tb_ing<-web_ing%>%html_nodes("table.table.table--primary.align--right")%>%html_table()
tb_ing

#nickel prices====
#This works, and includes more than Nickel price
url_ni<-"https://markets.businessinsider.com/commodities/realtime-chart/nickel-price"
web_ni<-read_html(url_ni)
tb_ni<-web_ni%>%html_nodes("tbody.table__tbody")%>%html_table()
tb_ni

#nickel prices
#another site for nickel prices
#This also works, and includes more than Nickel price
url_ni2<-"https://tradingeconomics.com/commodity/nickel"
web_ni2<-read_html(url_ni2)
tb_ni2<-web_ni2%>%html_nodes("table.table.table-hover.sortable-theme-minimal.table-heatmap")%>%html_table()
tb_ni2

#Lithium prices====
#included in the same sites of Nickel above

#rare earth oxides====
#This doesn't work
url_reo<-"https://www.metal.com/Rare-Earth-Oxides"
web_reo<-read_html(url_reo)
tb_reo<-web_reo%>%html_nodes("div.body___3HV_m.scroll___35LVM")%>%html_table()
tb_reo

#didn't find free data source for rare earth oxides yet