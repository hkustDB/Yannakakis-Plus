create or replace view aggView3650170687904128764 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin7065090790791911775 as (
with aggView2273145340828946960 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView2273145340828946960 where t.id=aggView2273145340828946960.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggView4274070969010268230 as select v29, v33 from aggJoin7065090790791911775 group by v29,v33;
create or replace view aggJoin1681654716957709181 as (
with aggView7672018392431753971 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7672018392431753971 where ml.link_type_id=aggView7672018392431753971.v13);
create or replace view aggJoin4504827541131743721 as (
with aggView2561446285846072459 as (select v17, MIN(v2) as v44 from aggView3650170687904128764 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView2561446285846072459 where mc.company_id=aggView2561446285846072459.v17);
create or replace view aggJoin5442299107772758320 as (
with aggView7557815816941541209 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView7557815816941541209 where mk.keyword_id=aggView7557815816941541209.v27);
create or replace view aggJoin3326993116242449010 as (
with aggView8124812431877267412 as (select v29 from aggJoin5442299107772758320 group by v29)
select v29, v45 as v45 from aggJoin1681654716957709181 join aggView8124812431877267412 using(v29));
create or replace view aggJoin1084232429980443936 as (
with aggView7558361267628704015 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4504827541131743721 join aggView7558361267628704015 using(v18));
create or replace view aggJoin1827312945371947572 as (
with aggView1143798673732553750 as (select v29, MIN(v44) as v44 from aggJoin1084232429980443936 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin3326993116242449010 join aggView1143798673732553750 using(v29));
create or replace view aggJoin7692831385610665700 as (
with aggView9203327081317692562 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin1827312945371947572 group by v29,v44,v45)
select v33, v45, v44 from aggView4274070969010268230 join aggView9203327081317692562 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin7692831385610665700;
