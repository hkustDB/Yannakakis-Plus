create or replace view aggView9010680436211865952 as select id as v29, title as v30 from title as t where production_year>=2000 and production_year<=2010;
create or replace view aggView6222635549740239781 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7741025629747100247 as (
with aggView6480229253791453612 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView6480229253791453612 where mi_idx.info_type_id=aggView6480229253791453612.v26);
create or replace view aggJoin6950335181401706774 as (
with aggView8824595277303347196 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView8824595277303347196 where mi.info_type_id=aggView8824595277303347196.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin7530173231537251656 as (
with aggView5080209745664947732 as (select v29 from aggJoin6950335181401706774 group by v29)
select v29, v27 from aggJoin7741025629747100247 join aggView5080209745664947732 using(v29));
create or replace view aggJoin4276377039986674557 as (
with aggView2668479979954358144 as (select v29, v27 from aggJoin7530173231537251656 group by v29,v27)
select v29, v27 from aggView2668479979954358144 where v27>'7.0');
create or replace view aggJoin7097868228082256079 as (
with aggView5717013717606219155 as (select v29, MIN(v30) as v43 from aggView9010680436211865952 group by v29)
select v29, v27, v43 from aggJoin4276377039986674557 join aggView5717013717606219155 using(v29));
create or replace view aggJoin807068816341566197 as (
with aggView8167248480405074271 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin7097868228082256079 group by v29,v43)
select company_id as v1, company_type_id as v8, v43, v42 from movie_companies as mc, aggView8167248480405074271 where mc.movie_id=aggView8167248480405074271.v29);
create or replace view aggJoin3124072968342936296 as (
with aggView8859722387382458972 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v43, v42 from aggJoin807068816341566197 join aggView8859722387382458972 using(v8));
create or replace view aggJoin6107346667497180174 as (
with aggView7095162271013970418 as (select v1, MIN(v43) as v43, MIN(v42) as v42 from aggJoin3124072968342936296 group by v1,v42,v43)
select v2, v43, v42 from aggView6222635549740239781 join aggView7095162271013970418 using(v1));
select MIN(v2) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin6107346667497180174;
