create or replace view aggJoin4338473248703096859 as (
with aggView5873566523119051687 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView5873566523119051687 where t.kind_id=aggView5873566523119051687.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin3697149883884358128 as (
with aggView475670162376370620 as (select v23, MIN(v24) as v36 from aggJoin4338473248703096859 group by v23)
select movie_id as v23, info_type_id as v3, info as v18, v36 from movie_info_idx as mi_idx, aggView475670162376370620 where mi_idx.movie_id=aggView475670162376370620.v23 and info>'6.0');
create or replace view aggJoin5415387855631202646 as (
with aggView7169865602905801414 as (select id as v3 from info_type as it2 where info= 'rating')
select v23, v18, v36 from aggJoin3697149883884358128 join aggView7169865602905801414 using(v3));
create or replace view aggJoin6787902754110180817 as (
with aggView21375479627586433 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView21375479627586433 where mi.info_type_id=aggView21375479627586433.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin8515435757766042434 as (
with aggView1644984718780910980 as (select v23 from aggJoin6787902754110180817 group by v23)
select v23, v18, v36 as v36 from aggJoin5415387855631202646 join aggView1644984718780910980 using(v23));
create or replace view aggJoin742371903816137033 as (
with aggView443259183078671579 as (select v23, MIN(v36) as v36, MIN(v18) as v35 from aggJoin8515435757766042434 group by v23,v36)
select keyword_id as v5, v36, v35 from movie_keyword as mk, aggView443259183078671579 where mk.movie_id=aggView443259183078671579.v23);
create or replace view aggJoin4104897126360905588 as (
with aggView2249300949945885631 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select v36, v35 from aggJoin742371903816137033 join aggView2249300949945885631 using(v5));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin4104897126360905588;
