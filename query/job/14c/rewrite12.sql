create or replace view aggJoin5039674737543509341 as (
with aggView6052199978586830581 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView6052199978586830581 where mi_idx.info_type_id=aggView6052199978586830581.v3 and info<'8.5');
create or replace view aggJoin6748423568420731641 as (
with aggView5491336535813705212 as (select v23, MIN(v18) as v35 from aggJoin5039674737543509341 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v35 from movie_info as mi, aggView5491336535813705212 where mi.movie_id=aggView5491336535813705212.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4042437952799427247 as (
with aggView1135393440463420098 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView1135393440463420098 where t.kind_id=aggView1135393440463420098.v8 and production_year>2005);
create or replace view aggJoin7078177922578792418 as (
with aggView5951061577435160567 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView5951061577435160567 where mk.keyword_id=aggView5951061577435160567.v5);
create or replace view aggJoin3501662138794791213 as (
with aggView5281199219480290960 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v35 from aggJoin6748423568420731641 join aggView5281199219480290960 using(v1));
create or replace view aggJoin1902487290419213449 as (
with aggView3066278336225334567 as (select v23, MIN(v35) as v35 from aggJoin3501662138794791213 group by v23,v35)
select v23, v24, v27, v35 from aggJoin4042437952799427247 join aggView3066278336225334567 using(v23));
create or replace view aggJoin7615862691187851378 as (
with aggView6375967662703971827 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin1902487290419213449 group by v23,v35)
select v35, v36 from aggJoin7078177922578792418 join aggView6375967662703971827 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin7615862691187851378;
