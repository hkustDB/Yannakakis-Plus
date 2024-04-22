create or replace view aggJoin3179233452113579892 as (
with aggView8461354778774343153 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8461354778774343153 where mk.keyword_id=aggView8461354778774343153.v5);
create or replace view aggJoin482789800580628081 as (
with aggView6061221378397490874 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6061221378397490874 where mi_idx.info_type_id=aggView6061221378397490874.v3);
create or replace view aggJoin7594151518491570144 as (
with aggView6753208657759859810 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView6753208657759859810 where t.kind_id=aggView6753208657759859810.v8 and production_year>2005);
create or replace view aggView2862643055109671831 as select v24, v23 from aggJoin7594151518491570144 group by v24,v23;
create or replace view aggJoin1386325557751934105 as (
with aggView4363987702502598767 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4363987702502598767 where mi.info_type_id=aggView4363987702502598767.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2977348004238156569 as (
with aggView973489628272706022 as (select v23 from aggJoin1386325557751934105 group by v23)
select v23 from aggJoin3179233452113579892 join aggView973489628272706022 using(v23));
create or replace view aggJoin6720835945388841436 as (
with aggView8246093282531539002 as (select v23 from aggJoin2977348004238156569 group by v23)
select v23, v18 from aggJoin482789800580628081 join aggView8246093282531539002 using(v23));
create or replace view aggJoin6869749746317238407 as (
with aggView2105801765126062193 as (select v18, v23 from aggJoin6720835945388841436 group by v18,v23)
select v23, v18 from aggView2105801765126062193 where v18<'8.5');
create or replace view aggJoin2857250411734414409 as (
with aggView6745690178660801753 as (select v23, MIN(v18) as v35 from aggJoin6869749746317238407 group by v23)
select v24, v35 from aggView2862643055109671831 join aggView6745690178660801753 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin2857250411734414409;
