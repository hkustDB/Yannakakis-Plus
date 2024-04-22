create or replace view aggView7919689392217094894 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView3104469352801629237 as select title as v28, id as v24 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggJoin3946181014731494629 as (
with aggView8907613686644148298 as (select v17, MIN(v2) as v39 from aggView7919689392217094894 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView8907613686644148298 where mc.company_id=aggView8907613686644148298.v17);
create or replace view aggJoin1637313680122923471 as (
with aggView3808289185825795710 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView3808289185825795710 where ml.link_type_id=aggView3808289185825795710.v13);
create or replace view aggJoin1654593474952464394 as (
with aggView7891288595130687434 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7891288595130687434 where mk.keyword_id=aggView7891288595130687434.v22);
create or replace view aggJoin3076442778314453096 as (
with aggView4207331430892776666 as (select v24 from aggJoin1654593474952464394 group by v24)
select v24, v40 as v40 from aggJoin1637313680122923471 join aggView4207331430892776666 using(v24));
create or replace view aggJoin6358864548857141076 as (
with aggView4845174408910932296 as (select v24, MIN(v40) as v40 from aggJoin3076442778314453096 group by v24,v40)
select v24, v18, v39 as v39, v40 from aggJoin3946181014731494629 join aggView4845174408910932296 using(v24));
create or replace view aggJoin6371741049925490924 as (
with aggView4853713939484732348 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v40 from aggJoin6358864548857141076 join aggView4853713939484732348 using(v18));
create or replace view aggJoin2242565013708038476 as (
with aggView7061639293505068787 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin6371741049925490924 group by v24,v39,v40)
select v28, v39, v40 from aggView3104469352801629237 join aggView7061639293505068787 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin2242565013708038476;
