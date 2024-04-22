create or replace view aggJoin199863096771139630 as (
with aggView3580565420097421194 as (select id as v29, title as v43 from title as t where production_year>=2000 and production_year<=2010)
select movie_id as v29, info_type_id as v26, info as v27, v43 from movie_info_idx as mi_idx, aggView3580565420097421194 where mi_idx.movie_id=aggView3580565420097421194.v29 and info>'7.0');
create or replace view aggJoin4416850231024124292 as (
with aggView5605978336173116227 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView5605978336173116227 where mc.company_id=aggView5605978336173116227.v1);
create or replace view aggJoin18027372538441562 as (
with aggView2546505563973303332 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin4416850231024124292 join aggView2546505563973303332 using(v8));
create or replace view aggJoin9040848081184989592 as (
with aggView55472339918822799 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27, v43 from aggJoin199863096771139630 join aggView55472339918822799 using(v26));
create or replace view aggJoin4256081296628931320 as (
with aggView7927515184120722566 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7927515184120722566 where mi.info_type_id=aggView7927515184120722566.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin1598142856312665415 as (
with aggView1990034724089383042 as (select v29 from aggJoin4256081296628931320 group by v29)
select v29, v27, v43 as v43 from aggJoin9040848081184989592 join aggView1990034724089383042 using(v29));
create or replace view aggJoin5236560054523134158 as (
with aggView8256073020853964747 as (select v29, MIN(v43) as v43, MIN(v27) as v42 from aggJoin1598142856312665415 group by v29,v43)
select v41 as v41, v43, v42 from aggJoin18027372538441562 join aggView8256073020853964747 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin5236560054523134158;
