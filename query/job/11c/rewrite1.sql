create or replace view aggView5075150984327724883 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin7819743817276902807 as (
with aggView9141895720415792407 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView9141895720415792407 where mk.keyword_id=aggView9141895720415792407.v22);
create or replace view aggJoin1741786586831271486 as (
with aggView6554792505250790431 as (select v24 from aggJoin7819743817276902807 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView6554792505250790431 where ml.movie_id=aggView6554792505250790431.v24);
create or replace view aggJoin1361384792075739567 as (
with aggView3311500093565918135 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView3311500093565918135 where mc.company_type_id=aggView3311500093565918135.v18);
create or replace view aggView5708386727477591851 as select v19, v24, v17 from aggJoin1361384792075739567 group by v19,v24,v17;
create or replace view aggJoin4834794427336488068 as (
with aggView5435137843427842821 as (select id as v13 from link_type as lt)
select v24 from aggJoin1741786586831271486 join aggView5435137843427842821 using(v13));
create or replace view aggJoin6738358114485185444 as (
with aggView8274538605223186402 as (select v24 from aggJoin4834794427336488068 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView8274538605223186402 where t.id=aggView8274538605223186402.v24 and production_year>1950);
create or replace view aggView8506110262648944617 as select v28, v24 from aggJoin6738358114485185444 group by v28,v24;
create or replace view aggJoin3826148125588920279 as (
with aggView5616145744197496342 as (select v17, MIN(v2) as v39 from aggView5075150984327724883 group by v17)
select v19, v24, v39 from aggView5708386727477591851 join aggView5616145744197496342 using(v17));
create or replace view aggJoin3478024591607645333 as (
with aggView2648093911993277760 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin3826148125588920279 group by v24,v39)
select v28, v39, v40 from aggView8506110262648944617 join aggView2648093911993277760 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin3478024591607645333;
