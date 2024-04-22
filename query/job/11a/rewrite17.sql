create or replace view aggJoin3699728445673363017 as (
with aggView4070823181551169996 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView4070823181551169996 where mc.company_id=aggView4070823181551169996.v17);
create or replace view aggJoin4140137097315873421 as (
with aggView1510175961948729148 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView1510175961948729148 where ml.link_type_id=aggView1510175961948729148.v13);
create or replace view aggJoin1774428342718277879 as (
with aggView7969066460811872658 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7969066460811872658 where mk.keyword_id=aggView7969066460811872658.v22);
create or replace view aggJoin3579727225882797780 as (
with aggView3482411899088841636 as (select v24, MIN(v40) as v40 from aggJoin4140137097315873421 group by v24,v40)
select id as v24, title as v28, production_year as v31, v40 from title as t, aggView3482411899088841636 where t.id=aggView3482411899088841636.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin7498843310500494793 as (
with aggView5608746001245260437 as (select v24, MIN(v40) as v40, MIN(v28) as v41 from aggJoin3579727225882797780 group by v24,v40)
select v24, v40, v41 from aggJoin1774428342718277879 join aggView5608746001245260437 using(v24));
create or replace view aggJoin4009448918061610308 as (
with aggView8392581601489329289 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin3699728445673363017 join aggView8392581601489329289 using(v18));
create or replace view aggJoin5505844511933156563 as (
with aggView76654772450069541 as (select v24, MIN(v39) as v39 from aggJoin4009448918061610308 group by v24,v39)
select v40 as v40, v41 as v41, v39 from aggJoin7498843310500494793 join aggView76654772450069541 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5505844511933156563;
