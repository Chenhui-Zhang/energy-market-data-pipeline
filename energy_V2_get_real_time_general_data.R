#Developed for Trivium energy team
#Energy market data pipeline project

###########################################################
#Basic idea====
#Step 0. Manually create a demo.xlsx in destination format
#Step 1. Load the old data from demo.xlsx
#Step 2. Pull the new data from businessinsider
#Step 3. Append new data to old data
#Step 4. Overwrite demo.xlsx
###########################################################

#Set working directory ====
setwd("D:/Trivium/Trivium_Energy_Market_Data_Pipeline_Project")

#Load packages ====
library(rvest)
library(XML)
library(openxlsx)
library(dplyr)

#Step 1. Load the old data from demo.xlsx ====
old_demo<-read.xlsx("demo.xlsx")
old_ng<-read.xlsx("demo.xlsx",sheet="Natural Gas")
old_coal<-read.xlsx("demo.xlsx",sheet="Coal")
old_ob<-read.xlsx("demo.xlsx",sheet="Oil(Brent)")
old_owti<-read.xlsx("demo.xlsx",sheet="Oil(WTI)")
old_al<-read.xlsx("demo.xlsx",sheet="Aluminum")
old_pb<-read.xlsx("demo.xlsx",sheet="Lead")
old_ni<-read.xlsx("demo.xlsx",sheet="Nickel")
old_zn<-read.xlsx("demo.xlsx",sheet="Zinc")


#Step 2. Pull the new data from businessinsider ====
url_bi<-"https://markets.businessinsider.com/commodities"
web_bi<-read_html(url_bi)
tb_bi<-web_bi%>%html_nodes("table.table.table--col-1-font-color-black.table--suppresses-line-breaks.margin-vertical--medium")%>%html_table()
tb_energy<-tb_bi[[1]]
tb_metal<-tb_bi[[2]]
df_energy_full<-as.data.frame(tb_energy)
names(df_energy_full)<-c("Energy","Price","%","+/-","Unit","Time")
df_energy<-df_energy_full%>%select(Energy,Price,Unit,Time)
df_energy$Import_Date<-Sys.Date()%>%as.character()

df_metal_full<-as.data.frame(tb_metal)
names(df_metal_full)<-c("Industrial_Metals","Price","%","+/-","Unit","Time")
df_metal<-df_metal_full%>%select(`Industrial_Metals`,Price,Unit,Time)
df_metal$Import_Date<-Sys.Date()%>%as.character()

##Note: Time is the time directly from businessinsider
##Note: Date is the system date when running the code
##Since the update frequency of each commodity varies,
##It makes more sense to write down both the time and date

#Natural gas(Henry Hub)
#USD per MMBtu
df_ng<-df_energy[which(df_energy$Energy=="Natural Gas (Henry Hub)"),]

#Coal
#USD per ton
df_coal<-df_energy[which(df_energy$Energy=="Coal"),]

#Oil Brent
df_ob<-df_energy[which(df_energy$Energy=="Oil (Brent)"),]

#Oil WTI
df_owti<-df_energy[which(df_energy$Energy=="Oil (WTI)"),]

#Aluminum
df_al<-df_metal[which(df_metal$`Industrial_Metals`=="Aluminium"),]

#Lead
df_pb<-df_metal[which(df_metal$`Industrial_Metals`=="Lead"),]

#Nickel
df_ni<-df_metal[which(df_metal$`Industrial_Metals`=="Nickel"),]

#Zinc
df_zn<-df_metal[which(df_metal$`Industrial_Metals`=="Zinc"),]


#Step 3. Append new data to old data ====
ng<-rbind(old_ng,df_ng)
coal<-rbind(old_coal,df_coal)
ob<-rbind(old_ob,df_ob)
owti<-rbind(old_owti,df_owti)
al<-rbind(old_al,df_al)
pb<-rbind(old_pb,df_pb)
ni<-rbind(old_ni,df_ni)
zn<-rbind(old_zn,df_zn)

list_data<-list("Natural Gas"=ng,"Coal"=coal,"Oil(Brent)"=ob,"Oil(WTI)"=owti,"Aluminum"=al,"Lead"=pb,"Nickel"=ni,"Zinc"=zn)

#Step 4. Overwrite demo.xlsx ====
write.xlsx(list_data,file="demo.xlsx")
