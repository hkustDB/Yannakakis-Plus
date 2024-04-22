create or replace view aggView8157815004133809023 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView6896467949541874228 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8345328246739026530 as (
with aggView1271450424247293968 as (select v17, MIN(v2) as v44 from aggView6896467949541874228 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView1271450424247293968 where mc.company_id=aggView1271450424247293968.v17);
create or replace view aggJoin5810035054801601140 as (
with aggView7384328217556778520 as (select v29, MIN(v33) as v46 from aggView8157815004133809023 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView7384328217556778520 where ml.movie_id=aggView7384328217556778520.v29);
create or replace view aggJoin1152232122710466121 as (
with aggView108240880860299017 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView108240880860299017 where mk.keyword_id=aggView108240880860299017.v27);
create or replace view aggJoin4495435968956197091 as (
with aggView273502179563935208 as (select v29 from aggJoin1152232122710466121 group by v29)
select movie_id as v29, info as v23 from movie_info as mi, aggView273502179563935208 where mi.movie_id=aggView273502179563935208.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8969920248264596611 as (
with aggView3398673855333710905 as (select v29 from aggJoin4495435968956197091 group by v29)
select v29, v18, v44 as v44 from aggJoin8345328246739026530 join aggView3398673855333710905 using(v29));
create or replace view aggJoin7630796131326040077 as (
with aggView7671460474925274666 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin8969920248264596611 join aggView7671460474925274666 using(v18));
create or replace view aggJoin6798600534438117043 as (
with aggView7540649601388754865 as (select v29, MIN(v44) as v44 from aggJoin7630796131326040077 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin5810035054801601140 join aggView7540649601388754865 using(v29));
create or replace view aggJoin8550351954870923064 as (
with aggView1674048764638155723 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin6798600534438117043 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView1674048764638155723 where lt.id=aggView1674048764638155723.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin8550351954870923064;
