select l.DISTRICT_CODE "CODE",d.DISTRICT_NAME "NAME",l.LATITUDE "LAT",l.LONGITUDE "LON"
from LOCATION_TBL l
inner join DISTRICT d
on l.DISTRICT_CODE = d.DISTRICT_CODE
where l.DISTRICT_CODE <> '1101'
order by (select pow(l.LATITUDE - l1101.LATITUDE,2) +
                 pow(l.LONGITUDE - l1101.LONGITUDE,2)
          from LOCATION_TBL l1101
          where l1101.DISTRICT_CODE = '1101') desc, l.DISTRICT_CODE;