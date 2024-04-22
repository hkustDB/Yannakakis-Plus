create or replace view aggView3910792379448095717 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView6020363980302611549 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggJoin5342885766980819358 as (
with aggView5087010024771402842 as (select v17, MIN(v2) as v44 from aggView3910792379448095717 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5087010024771402842 where mc.company_id=aggView5087010024771402842.v17);
create or replace view aggJoin1377826738332418226 as (
with aggView3140728919395369829 as (select v29, MIN(v33) as v46 from aggView6020363980302611549 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView3140728919395369829 where ml.movie_id=aggView3140728919395369829.v29);
create or replace view aggJoin2117820970638603135 as (
with aggView66147081607904968 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView66147081607904968 where mk.keyword_id=aggView66147081607904968.v27);
create or replace view aggJoin8185779218057149229 as (
with aggView101740351226989723 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin2117820970638603135 join aggView101740351226989723 using(v29));
create or replace view aggJoin215215741221841907 as (
with aggView8550451749717963960 as (select v29 from aggJoin8185779218057149229 group by v29)
select v29, v18, v44 as v44 from aggJoin5342885766980819358 join aggView8550451749717963960 using(v29));
create or replace view aggJoin8769288566988481044 as (
with aggView2870553146846554854 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin215215741221841907 join aggView2870553146846554854 using(v18));
create or replace view aggJoin7078192353267554294 as (
with aggView3247486895413858753 as (select v29, MIN(v44) as v44 from aggJoin8769288566988481044 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin1377826738332418226 join aggView3247486895413858753 using(v29));
create or replace view aggJoin1996770129368560166 as (
with aggView4056329306175096911 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin7078192353267554294 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView4056329306175096911 where lt.id=aggView4056329306175096911.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin1996770129368560166;
