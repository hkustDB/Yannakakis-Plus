create or replace view aggView7793265674959366129 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3660692763733433999 as (
with aggView5277286860116620086 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView5277286860116620086 where t.id=aggView5277286860116620086.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin805666620610832896 as (
with aggView9019625376232031348 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView9019625376232031348 where mk.keyword_id=aggView9019625376232031348.v27);
create or replace view aggJoin5800451344338246251 as (
with aggView8917631961531444729 as (select v29 from aggJoin805666620610832896 group by v29)
select v29, v33, v36 from aggJoin3660692763733433999 join aggView8917631961531444729 using(v29));
create or replace view aggView2806676983444024063 as select v33, v29 from aggJoin5800451344338246251 group by v33,v29;
create or replace view aggJoin6156239469856125987 as (
with aggView2548883388111419650 as (select v17, MIN(v2) as v44 from aggView7793265674959366129 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView2548883388111419650 where mc.company_id=aggView2548883388111419650.v17);
create or replace view aggJoin4684187946399728658 as (
with aggView7319938951024658502 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6156239469856125987 join aggView7319938951024658502 using(v18));
create or replace view aggJoin1635450298762713588 as (
with aggView1885843752130765428 as (select v29, MIN(v44) as v44 from aggJoin4684187946399728658 group by v29,v44)
select v33, v29, v44 from aggView2806676983444024063 join aggView1885843752130765428 using(v29));
create or replace view aggJoin8099037973743016026 as (
with aggView1486449973227247969 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin1635450298762713588 group by v29,v44)
select link_type_id as v13, v44, v46 from movie_link as ml, aggView1486449973227247969 where ml.movie_id=aggView1486449973227247969.v29);
create or replace view aggJoin850254962710594925 as (
with aggView3394855922892540106 as (select v13, MIN(v44) as v44, MIN(v46) as v46 from aggJoin8099037973743016026 group by v13,v44,v46)
select link as v14, v44, v46 from link_type as lt, aggView3394855922892540106 where lt.id=aggView3394855922892540106.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin850254962710594925;
