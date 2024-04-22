create or replace view aggView8540942777741072784 as select title as v28, id as v24 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView2103001466623016670 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8387411469173804572 as (
with aggView7279823910109995723 as (select v24, MIN(v28) as v41 from aggView8540942777741072784 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView7279823910109995723 where ml.movie_id=aggView7279823910109995723.v24);
create or replace view aggJoin3276252647200329153 as (
with aggView4805878612758168121 as (select v17, MIN(v2) as v39 from aggView2103001466623016670 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView4805878612758168121 where mc.company_id=aggView4805878612758168121.v17);
create or replace view aggJoin2240300261701469702 as (
with aggView6861723784887845365 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView6861723784887845365 where mk.keyword_id=aggView6861723784887845365.v22);
create or replace view aggJoin6392415968221327276 as (
with aggView6975174209763152563 as (select v24 from aggJoin2240300261701469702 group by v24)
select v24, v18, v39 as v39 from aggJoin3276252647200329153 join aggView6975174209763152563 using(v24));
create or replace view aggJoin8405178829396767859 as (
with aggView121944168607517096 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin6392415968221327276 join aggView121944168607517096 using(v18));
create or replace view aggJoin2976767693466668988 as (
with aggView5044783281894032831 as (select v24, MIN(v39) as v39 from aggJoin8405178829396767859 group by v24,v39)
select v13, v41 as v41, v39 from aggJoin8387411469173804572 join aggView5044783281894032831 using(v24));
create or replace view aggJoin4989414399207039657 as (
with aggView6924079881082471930 as (select v13, MIN(v41) as v41, MIN(v39) as v39 from aggJoin2976767693466668988 group by v13,v39,v41)
select link as v14, v41, v39 from link_type as lt, aggView6924079881082471930 where lt.id=aggView6924079881082471930.v13 and link LIKE '%follow%');
select MIN(v39) as v39,MIN(v14) as v40,MIN(v41) as v41 from aggJoin4989414399207039657;
