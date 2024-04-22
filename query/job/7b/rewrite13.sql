create or replace view aggView1089155225618770001 as select id as v38, title as v39 from title as t where production_year<=1984 and production_year>=1980;
create or replace view aggView2182597891172483788 as select name as v25, id as v24 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%';
create or replace view aggJoin4826506532723513155 as (
with aggView8279163634520002055 as (select v38, MIN(v39) as v51 from aggView1089155225618770001 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView8279163634520002055 where ci.movie_id=aggView8279163634520002055.v38);
create or replace view aggJoin8329407580691976573 as (
with aggView3166720810760665309 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView3166720810760665309 where pi.info_type_id=aggView3166720810760665309.v16 and note= 'Volker Boehm');
create or replace view aggJoin208816675075702138 as (
with aggView8069255060010933766 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView8069255060010933766 where ml.link_type_id=aggView8069255060010933766.v18);
create or replace view aggJoin2214450380265877038 as (
with aggView3240437978308666098 as (select v38 from aggJoin208816675075702138 group by v38)
select v24, v51 as v51 from aggJoin4826506532723513155 join aggView3240437978308666098 using(v38));
create or replace view aggJoin1747931302229876545 as (
with aggView205594683111816456 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin8329407580691976573 join aggView205594683111816456 using(v24));
create or replace view aggJoin4099702201825736099 as (
with aggView7119195305194537293 as (select v24 from aggJoin1747931302229876545 group by v24)
select v24, v51 as v51 from aggJoin2214450380265877038 join aggView7119195305194537293 using(v24));
create or replace view aggJoin4096565498843711450 as (
with aggView1842796637610849440 as (select v24, MIN(v51) as v51 from aggJoin4099702201825736099 group by v24,v51)
select v25, v51 from aggView2182597891172483788 join aggView1842796637610849440 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin4096565498843711450;
