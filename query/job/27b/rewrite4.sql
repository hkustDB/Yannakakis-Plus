create or replace view aggView7864605523604972463 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin2164447565340789006 as (
with aggView519064317243110844 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView519064317243110844 where cc.subject_id=aggView519064317243110844.v5);
create or replace view aggJoin4655500180587920827 as (
with aggView4335363525085445397 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin2164447565340789006 join aggView4335363525085445397 using(v7));
create or replace view aggJoin6448009652553416661 as (
with aggView141255923356144810 as (select v37 from aggJoin4655500180587920827 group by v37)
select id as v37, title as v41, production_year as v44 from title as t, aggView141255923356144810 where t.id=aggView141255923356144810.v37 and production_year= 1998);
create or replace view aggView2270252093015156227 as select v37, v41 from aggJoin6448009652553416661 group by v37,v41;
create or replace view aggJoin2744874063371782322 as (
with aggView5876849273853525487 as (select v37, MIN(v41) as v54 from aggView2270252093015156227 group by v37)
select movie_id as v37, link_type_id as v21, v54 from movie_link as ml, aggView5876849273853525487 where ml.movie_id=aggView5876849273853525487.v37);
create or replace view aggJoin1986451831826714665 as (
with aggView4642817261960955697 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select v37, v54, v53 from aggJoin2744874063371782322 join aggView4642817261960955697 using(v21));
create or replace view aggJoin3982353448406230035 as (
with aggView2378974487275761651 as (select v37, MIN(v54) as v54, MIN(v53) as v53 from aggJoin1986451831826714665 group by v37,v53,v54)
select movie_id as v37, company_id as v25, company_type_id as v26, v54, v53 from movie_companies as mc, aggView2378974487275761651 where mc.movie_id=aggView2378974487275761651.v37);
create or replace view aggJoin9206519340799638484 as (
with aggView5639395625965131977 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5639395625965131977 where mk.keyword_id=aggView5639395625965131977.v35);
create or replace view aggJoin1982914652980434159 as (
with aggView7547613539254954776 as (select v37 from aggJoin9206519340799638484 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView7547613539254954776 where mi.movie_id=aggView7547613539254954776.v37 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin8565442225682331965 as (
with aggView1399877419612741019 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v25, v54, v53 from aggJoin3982353448406230035 join aggView1399877419612741019 using(v26));
create or replace view aggJoin1233943640285548567 as (
with aggView6039720561567024485 as (select v37 from aggJoin1982914652980434159 group by v37)
select v25, v54 as v54, v53 as v53 from aggJoin8565442225682331965 join aggView6039720561567024485 using(v37));
create or replace view aggJoin1616958070078616949 as (
with aggView9167500872170484730 as (select v25, MIN(v54) as v54, MIN(v53) as v53 from aggJoin1233943640285548567 group by v25,v53,v54)
select v10, v54, v53 from aggView7864605523604972463 join aggView9167500872170484730 using(v25));
select MIN(v10) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin1616958070078616949;
