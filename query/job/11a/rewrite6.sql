create or replace view aggView8017854435311346741 as select title as v28, id as v24 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView3293995559217555252 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin6665352755948916490 as (
with aggView2413543022478141276 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView2413543022478141276 where ml.link_type_id=aggView2413543022478141276.v13);
create or replace view aggJoin5290008437939035662 as (
with aggView5594276682176575864 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView5594276682176575864 where mk.keyword_id=aggView5594276682176575864.v22);
create or replace view aggJoin5566748869165242054 as (
with aggView1341624773397702868 as (select v24, MIN(v40) as v40 from aggJoin6665352755948916490 group by v24,v40)
select v28, v24, v40 from aggView8017854435311346741 join aggView1341624773397702868 using(v24));
create or replace view aggJoin4885442059389502996 as (
with aggView5963046288215524055 as (select v24, MIN(v40) as v40, MIN(v28) as v41 from aggJoin5566748869165242054 group by v24,v40)
select movie_id as v24, company_id as v17, company_type_id as v18, v40, v41 from movie_companies as mc, aggView5963046288215524055 where mc.movie_id=aggView5963046288215524055.v24);
create or replace view aggJoin2116113094356425974 as (
with aggView332301195238105069 as (select v24 from aggJoin5290008437939035662 group by v24)
select v17, v18, v40 as v40, v41 as v41 from aggJoin4885442059389502996 join aggView332301195238105069 using(v24));
create or replace view aggJoin2685536248177406465 as (
with aggView2286673884387596360 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v40, v41 from aggJoin2116113094356425974 join aggView2286673884387596360 using(v18));
create or replace view aggJoin2072605969584708702 as (
with aggView699774417673324914 as (select v17, MIN(v40) as v40, MIN(v41) as v41 from aggJoin2685536248177406465 group by v17,v40,v41)
select v2, v40, v41 from aggView3293995559217555252 join aggView699774417673324914 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin2072605969584708702;
