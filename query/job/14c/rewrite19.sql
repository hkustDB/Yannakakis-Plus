create or replace view aggJoin3999996426636197008 as (
with aggView5412069890144136190 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView5412069890144136190 where t.kind_id=aggView5412069890144136190.v8 and production_year>2005);
create or replace view aggJoin3988285309059777445 as (
with aggView8907457220545105847 as (select v23, MIN(v24) as v36 from aggJoin3999996426636197008 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v36 from movie_info as mi, aggView8907457220545105847 where mi.movie_id=aggView8907457220545105847.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7160870938177789195 as (
with aggView3501534779189920390 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3501534779189920390 where mi_idx.info_type_id=aggView3501534779189920390.v3 and info<'8.5');
create or replace view aggJoin2005879073603699716 as (
with aggView7897195147623342660 as (select v23, MIN(v18) as v35 from aggJoin7160870938177789195 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView7897195147623342660 where mk.movie_id=aggView7897195147623342660.v23);
create or replace view aggJoin7371253904563750116 as (
with aggView8361049490435686416 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v23, v35 from aggJoin2005879073603699716 join aggView8361049490435686416 using(v5));
create or replace view aggJoin8622493944843542003 as (
with aggView4833215104724906712 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36 from aggJoin3988285309059777445 join aggView4833215104724906712 using(v1));
create or replace view aggJoin503570565606940022 as (
with aggView2704055821078085240 as (select v23, MIN(v36) as v36 from aggJoin8622493944843542003 group by v23,v36)
select v35 as v35, v36 from aggJoin7371253904563750116 join aggView2704055821078085240 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin503570565606940022;
