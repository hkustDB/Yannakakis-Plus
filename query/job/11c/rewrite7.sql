create or replace view aggJoin3664705789508765601 as (
with aggView5039666338594194480 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView5039666338594194480 where mc.company_id=aggView5039666338594194480.v17);
create or replace view aggJoin2520982355577210301 as (
with aggView3793886916698264460 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView3793886916698264460 where mk.keyword_id=aggView3793886916698264460.v22);
create or replace view aggJoin6859210318248024412 as (
with aggView429430545712520199 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin3664705789508765601 join aggView429430545712520199 using(v18));
create or replace view aggJoin9168134986668406494 as (
with aggView8527396761546342909 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin6859210318248024412 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView8527396761546342909 where t.id=aggView8527396761546342909.v24 and production_year>1950);
create or replace view aggJoin7584457391319969033 as (
with aggView2751853025107706141 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin9168134986668406494 group by v24,v39,v40)
select movie_id as v24, link_type_id as v13, v39, v40, v41 from movie_link as ml, aggView2751853025107706141 where ml.movie_id=aggView2751853025107706141.v24);
create or replace view aggJoin8748133397629567730 as (
with aggView1543530224206800634 as (select id as v13 from link_type as lt)
select v24, v39, v40, v41 from aggJoin7584457391319969033 join aggView1543530224206800634 using(v13));
create or replace view aggJoin8947566836356474080 as (
with aggView1431663062436937113 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v41) as v41 from aggJoin8748133397629567730 group by v24,v39,v40,v41)
select v39, v40, v41 from aggJoin2520982355577210301 join aggView1431663062436937113 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin8947566836356474080;
