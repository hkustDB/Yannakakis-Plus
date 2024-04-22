create or replace view aggView7059820961777251376 as select title as v28, id as v24 from title as t where production_year>1950;
create or replace view aggView475508859850449928 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin2211427089762987195 as (
with aggView6994761611012920272 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView6994761611012920272 where mk.keyword_id=aggView6994761611012920272.v22);
create or replace view aggJoin1564433046420322654 as (
with aggView616470747407849923 as (select v24 from aggJoin2211427089762987195 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView616470747407849923 where ml.movie_id=aggView616470747407849923.v24);
create or replace view aggJoin7591143002021530754 as (
with aggView5107183547566482650 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView5107183547566482650 where mc.company_type_id=aggView5107183547566482650.v18);
create or replace view aggJoin9062656464245717419 as (
with aggView3381741599648184361 as (select id as v13 from link_type as lt)
select v24 from aggJoin1564433046420322654 join aggView3381741599648184361 using(v13));
create or replace view aggJoin2370208094257284851 as (
with aggView3696824974290789359 as (select v24 from aggJoin9062656464245717419 group by v24)
select v24, v17, v19 from aggJoin7591143002021530754 join aggView3696824974290789359 using(v24));
create or replace view aggView2457437539559853814 as select v19, v24, v17 from aggJoin2370208094257284851 group by v19,v24,v17;
create or replace view aggJoin5550162881014496455 as (
with aggView9210975249984915883 as (select v24, MIN(v28) as v41 from aggView7059820961777251376 group by v24)
select v19, v17, v41 from aggView2457437539559853814 join aggView9210975249984915883 using(v24));
create or replace view aggJoin5335274523306515539 as (
with aggView885376571705589854 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin5550162881014496455 group by v17,v41)
select v2, v41, v40 from aggView475508859850449928 join aggView885376571705589854 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5335274523306515539;
