create or replace view aggJoin3941632084689772806 as (
with aggView5203395490613240724 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5203395490613240724 where mc.company_id=aggView5203395490613240724.v17);
create or replace view aggJoin128178788316483336 as (
with aggView3380281599343321616 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView3380281599343321616 where ml.link_type_id=aggView3380281599343321616.v13);
create or replace view aggJoin8494740712543282221 as (
with aggView4318299098275514113 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView4318299098275514113 where mk.keyword_id=aggView4318299098275514113.v22);
create or replace view aggJoin8920970748832797774 as (
with aggView1383029231578232910 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin3941632084689772806 join aggView1383029231578232910 using(v18));
create or replace view aggJoin4542524728280584181 as (
with aggView2737032672568670012 as (select v24, MIN(v39) as v39 from aggJoin8920970748832797774 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39 from title as t, aggView2737032672568670012 where t.id=aggView2737032672568670012.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin7642192144891927767 as (
with aggView2958667255282051764 as (select v24, MIN(v39) as v39, MIN(v28) as v41 from aggJoin4542524728280584181 group by v24,v39)
select v24, v40 as v40, v39, v41 from aggJoin128178788316483336 join aggView2958667255282051764 using(v24));
create or replace view aggJoin6853960462451453336 as (
with aggView5335296647044097564 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v41) as v41 from aggJoin7642192144891927767 group by v24,v39,v40,v41)
select v40, v39, v41 from aggJoin8494740712543282221 join aggView5335296647044097564 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin6853960462451453336;
