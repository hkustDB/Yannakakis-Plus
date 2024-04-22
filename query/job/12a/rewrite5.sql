create or replace view aggView6513940492543747780 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView3633075208299753726 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggJoin1636509127307825376 as (
with aggView6762893304253593168 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView6762893304253593168 where mi.info_type_id=aggView6762893304253593168.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin6800978333486462446 as (
with aggView135141066134273072 as (select v29 from aggJoin1636509127307825376 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView135141066134273072 where mi_idx.movie_id=aggView135141066134273072.v29);
create or replace view aggJoin4835947525054148608 as (
with aggView707243588356865767 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin6800978333486462446 join aggView707243588356865767 using(v26));
create or replace view aggJoin7389914895494928260 as (
with aggView818545053079409325 as (select v27, v29 from aggJoin4835947525054148608 group by v27,v29)
select v29, v27 from aggView818545053079409325 where v27>'8.0');
create or replace view aggJoin5484070272070224013 as (
with aggView3676431774368920962 as (select v1, MIN(v2) as v41 from aggView6513940492543747780 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView3676431774368920962 where mc.company_id=aggView3676431774368920962.v1);
create or replace view aggJoin5682791101940900002 as (
with aggView5304662592104329144 as (select v29, MIN(v30) as v43 from aggView3633075208299753726 group by v29)
select v29, v8, v41 as v41, v43 from aggJoin5484070272070224013 join aggView5304662592104329144 using(v29));
create or replace view aggJoin8467810499120905177 as (
with aggView8221665336227918113 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41, v43 from aggJoin5682791101940900002 join aggView8221665336227918113 using(v8));
create or replace view aggJoin4925558795080801011 as (
with aggView6368931399626534034 as (select v29, MIN(v41) as v41, MIN(v43) as v43 from aggJoin8467810499120905177 group by v29,v43,v41)
select v27, v41, v43 from aggJoin7389914895494928260 join aggView6368931399626534034 using(v29));
select MIN(v41) as v41,MIN(v27) as v42,MIN(v43) as v43 from aggJoin4925558795080801011;
