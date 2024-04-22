create or replace view aggView8761240252415963254 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=2000;
create or replace view aggView8114331464298381602 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8826788925276812431 as (
with aggView5299778841859723894 as (select v29, MIN(v33) as v46 from aggView8761240252415963254 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView5299778841859723894 where ml.movie_id=aggView5299778841859723894.v29);
create or replace view aggJoin6829785713858517227 as (
with aggView6127756876734374393 as (select v17, MIN(v2) as v44 from aggView8114331464298381602 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView6127756876734374393 where mc.company_id=aggView6127756876734374393.v17);
create or replace view aggJoin4181110496309714727 as (
with aggView4689951706266359557 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView4689951706266359557 where mk.keyword_id=aggView4689951706266359557.v27);
create or replace view aggJoin8974129204807428982 as (
with aggView1111737642009462221 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6829785713858517227 join aggView1111737642009462221 using(v18));
create or replace view aggJoin186314220658271830 as (
with aggView4222159181061018689 as (select v29 from aggJoin4181110496309714727 group by v29)
select movie_id as v29, info as v23 from movie_info as mi, aggView4222159181061018689 where mi.movie_id=aggView4222159181061018689.v29 and info IN ('Germany','German'));
create or replace view aggJoin2353518197239404686 as (
with aggView3490555813849797078 as (select v29 from aggJoin186314220658271830 group by v29)
select v29, v44 as v44 from aggJoin8974129204807428982 join aggView3490555813849797078 using(v29));
create or replace view aggJoin8962913632287531845 as (
with aggView6546725333458707463 as (select v29, MIN(v44) as v44 from aggJoin2353518197239404686 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin8826788925276812431 join aggView6546725333458707463 using(v29));
create or replace view aggJoin3814780862995761044 as (
with aggView770076973843060350 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin8962913632287531845 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView770076973843060350 where lt.id=aggView770076973843060350.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin3814780862995761044;
