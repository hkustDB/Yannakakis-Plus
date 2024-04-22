create or replace view aggView564313723517142067 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]';
create or replace view aggView1026113321396601920 as select id as v24, title as v28 from title as t where production_year>1950;
create or replace view aggJoin4221982389217743310 as (
with aggView2020114415951747482 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView2020114415951747482 where mk.keyword_id=aggView2020114415951747482.v22);
create or replace view aggJoin9192676755125091827 as (
with aggView1088373298437692152 as (select v24 from aggJoin4221982389217743310 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView1088373298437692152 where ml.movie_id=aggView1088373298437692152.v24);
create or replace view aggJoin2868740332294574355 as (
with aggView3380216137559295033 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView3380216137559295033 where mc.company_type_id=aggView3380216137559295033.v18);
create or replace view aggJoin9116899218293138656 as (
with aggView6820273964352689973 as (select id as v13 from link_type as lt)
select v24 from aggJoin9192676755125091827 join aggView6820273964352689973 using(v13));
create or replace view aggJoin1338241048106338291 as (
with aggView6682655915085514793 as (select v24 from aggJoin9116899218293138656 group by v24)
select v24, v17, v19 from aggJoin2868740332294574355 join aggView6682655915085514793 using(v24));
create or replace view aggView3604946992376834321 as select v19, v24, v17 from aggJoin1338241048106338291 group by v19,v24,v17;
create or replace view aggJoin8377214246342147407 as (
with aggView3130061140659500414 as (select v24, MIN(v28) as v41 from aggView1026113321396601920 group by v24)
select v19, v17, v41 from aggView3604946992376834321 join aggView3130061140659500414 using(v24));
create or replace view aggJoin4858539514512187876 as (
with aggView7644954805956188294 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin8377214246342147407 group by v17,v41)
select v2, v41, v40 from aggView564313723517142067 join aggView7644954805956188294 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4858539514512187876;
