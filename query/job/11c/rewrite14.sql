create or replace view aggJoin2955182908415661212 as (
with aggView2327812773801565571 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView2327812773801565571 where mc.company_id=aggView2327812773801565571.v17);
create or replace view aggJoin7791977839786968982 as (
with aggView4901036498913241729 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView4901036498913241729 where ml.movie_id=aggView4901036498913241729.v24);
create or replace view aggJoin8546695957194995804 as (
with aggView174238921341098315 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView174238921341098315 where mk.keyword_id=aggView174238921341098315.v22);
create or replace view aggJoin4380733605923001978 as (
with aggView7650896888413961525 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin2955182908415661212 join aggView7650896888413961525 using(v18));
create or replace view aggJoin5768376533577304856 as (
with aggView7316492124448191995 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin4380733605923001978 group by v24,v39)
select v24, v13, v41 as v41, v39, v40 from aggJoin7791977839786968982 join aggView7316492124448191995 using(v24));
create or replace view aggJoin7439285181643892863 as (
with aggView4902352307398476585 as (select id as v13 from link_type as lt)
select v24, v41, v39, v40 from aggJoin5768376533577304856 join aggView4902352307398476585 using(v13));
create or replace view aggJoin1926269895800365083 as (
with aggView5898107148835310234 as (select v24, MIN(v41) as v41, MIN(v39) as v39, MIN(v40) as v40 from aggJoin7439285181643892863 group by v24,v39,v40,v41)
select v41, v39, v40 from aggJoin8546695957194995804 join aggView5898107148835310234 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1926269895800365083;
