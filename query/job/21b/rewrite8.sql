create or replace view aggView6462857900428471827 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin2175075355082586726 as (
with aggView1414377307663559275 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1414377307663559275 where mk.keyword_id=aggView1414377307663559275.v27);
create or replace view aggJoin4272442203696102194 as (
with aggView702474176195429181 as (select v29 from aggJoin2175075355082586726 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView702474176195429181 where t.id=aggView702474176195429181.v29 and production_year<=2010 and production_year>=2000);
create or replace view aggView6516365919323405544 as select v33, v29 from aggJoin4272442203696102194 group by v33,v29;
create or replace view aggJoin9178263615712900086 as (
with aggView824984082903748070 as (select v29, MIN(v33) as v46 from aggView6516365919323405544 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView824984082903748070 where ml.movie_id=aggView824984082903748070.v29);
create or replace view aggJoin517295817099323351 as (
with aggView5169595705196137409 as (select v17, MIN(v2) as v44 from aggView6462857900428471827 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5169595705196137409 where mc.company_id=aggView5169595705196137409.v17);
create or replace view aggJoin633578164534065143 as (
with aggView2295216215870957325 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin517295817099323351 join aggView2295216215870957325 using(v18));
create or replace view aggJoin8389758789603647676 as (
with aggView5063123053503104154 as (select movie_id as v29 from movie_info as mi where info IN ('Germany','German') group by movie_id)
select v29, v44 as v44 from aggJoin633578164534065143 join aggView5063123053503104154 using(v29));
create or replace view aggJoin8780410859916264686 as (
with aggView1982932880060828924 as (select v29, MIN(v44) as v44 from aggJoin8389758789603647676 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin9178263615712900086 join aggView1982932880060828924 using(v29));
create or replace view aggJoin4418066439329598953 as (
with aggView8981068498136586612 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin8780410859916264686 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView8981068498136586612 where lt.id=aggView8981068498136586612.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin4418066439329598953;
