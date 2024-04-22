create or replace view aggView4753209667824596027 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView1396092531697677177 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=1950;
create or replace view aggJoin3307572026239004689 as (
with aggView7504564505054840607 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7504564505054840607 where ml.link_type_id=aggView7504564505054840607.v13);
create or replace view aggJoin4690022016374508040 as (
with aggView7197592666554471564 as (select v29, MIN(v33) as v46 from aggView1396092531697677177 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView7197592666554471564 where mc.movie_id=aggView7197592666554471564.v29);
create or replace view aggJoin2209841692511209789 as (
with aggView8458858905763099484 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29, v17, v18, v46 as v46 from aggJoin4690022016374508040 join aggView8458858905763099484 using(v29));
create or replace view aggJoin360138281773331342 as (
with aggView1248099625654342470 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v17, v46 from aggJoin2209841692511209789 join aggView1248099625654342470 using(v18));
create or replace view aggJoin3197874161231557734 as (
with aggView208681764344405909 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView208681764344405909 where mk.keyword_id=aggView208681764344405909.v27);
create or replace view aggJoin4155159254733201216 as (
with aggView9219552876415704767 as (select v29 from aggJoin3197874161231557734 group by v29)
select v29, v45 as v45 from aggJoin3307572026239004689 join aggView9219552876415704767 using(v29));
create or replace view aggJoin5106587667132618175 as (
with aggView4840701129399492131 as (select v29, MIN(v45) as v45 from aggJoin4155159254733201216 group by v29,v45)
select v17, v46 as v46, v45 from aggJoin360138281773331342 join aggView4840701129399492131 using(v29));
create or replace view aggJoin4146353852765094708 as (
with aggView6522812421855824482 as (select v17, MIN(v46) as v46, MIN(v45) as v45 from aggJoin5106587667132618175 group by v17,v45,v46)
select v2, v46, v45 from aggView4753209667824596027 join aggView6522812421855824482 using(v17));
select MIN(v2) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin4146353852765094708;
