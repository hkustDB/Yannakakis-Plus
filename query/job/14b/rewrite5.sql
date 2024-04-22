create or replace view aggJoin7103171629473578446 as (
with aggView8323670445975579615 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView8323670445975579615 where t.kind_id=aggView8323670445975579615.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggView6324811866199281575 as select v23, v24 from aggJoin7103171629473578446 group by v23,v24;
create or replace view aggJoin7418433897705997595 as (
with aggView1762159724509240889 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1762159724509240889 where mi_idx.info_type_id=aggView1762159724509240889.v3);
create or replace view aggJoin3756219400665119090 as (
with aggView2470377214878306726 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView2470377214878306726 where mk.keyword_id=aggView2470377214878306726.v5);
create or replace view aggJoin625986841479975573 as (
with aggView2417320388553267276 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView2417320388553267276 where mi.info_type_id=aggView2417320388553267276.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin106017185127366030 as (
with aggView2569537255216220913 as (select v23 from aggJoin3756219400665119090 group by v23)
select v23, v13 from aggJoin625986841479975573 join aggView2569537255216220913 using(v23));
create or replace view aggJoin2034328899184574830 as (
with aggView3400923544556077212 as (select v23 from aggJoin106017185127366030 group by v23)
select v23, v18 from aggJoin7418433897705997595 join aggView3400923544556077212 using(v23));
create or replace view aggJoin8323896561485917197 as (
with aggView2812755818928131065 as (select v23, v18 from aggJoin2034328899184574830 group by v23,v18)
select v23, v18 from aggView2812755818928131065 where v18>'6.0');
create or replace view aggJoin5568065544312373672 as (
with aggView4519380877897010134 as (select v23, MIN(v18) as v35 from aggJoin8323896561485917197 group by v23)
select v24, v35 from aggView6324811866199281575 join aggView4519380877897010134 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin5568065544312373672;
