create or replace view aggJoin510267962133349981 as (
with aggView3041903159174988345 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView3041903159174988345 where t.kind_id=aggView3041903159174988345.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin6831550871127393365 as (
with aggView8268388581249342149 as (select v23, MIN(v24) as v36 from aggJoin510267962133349981 group by v23)
select movie_id as v23, info_type_id as v1, info as v13, v36 from movie_info as mi, aggView8268388581249342149 where mi.movie_id=aggView8268388581249342149.v23 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin5850947349094886052 as (
with aggView2203284993433622047 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2203284993433622047 where mi_idx.info_type_id=aggView2203284993433622047.v3 and info>'6.0');
create or replace view aggJoin8122003332007494362 as (
with aggView2604726656953957018 as (select v23, MIN(v18) as v35 from aggJoin5850947349094886052 group by v23)
select movie_id as v23, keyword_id as v5, v35 from movie_keyword as mk, aggView2604726656953957018 where mk.movie_id=aggView2604726656953957018.v23);
create or replace view aggJoin3830288154994115766 as (
with aggView1434879514670131958 as (select id as v1 from info_type as it1 where info= 'countries')
select v23, v13, v36 from aggJoin6831550871127393365 join aggView1434879514670131958 using(v1));
create or replace view aggJoin2721171121539581488 as (
with aggView7623371518628891933 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v23, v35 from aggJoin8122003332007494362 join aggView7623371518628891933 using(v5));
create or replace view aggJoin6730984553564121494 as (
with aggView1450375288291259132 as (select v23, MIN(v36) as v36 from aggJoin3830288154994115766 group by v23,v36)
select v35 as v35, v36 from aggJoin2721171121539581488 join aggView1450375288291259132 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin6730984553564121494;
