create or replace view aggView1717097571884043917 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5021035977589062343 as (
with aggView3459719555789167326 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView3459719555789167326 where mk.keyword_id=aggView3459719555789167326.v22);
create or replace view aggJoin652134175530144678 as (
with aggView3800435274277197785 as (select v24 from aggJoin5021035977589062343 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView3800435274277197785 where t.id=aggView3800435274277197785.v24 and production_year<=2000 and production_year>=1950);
create or replace view aggView6388006244237411863 as select v28, v24 from aggJoin652134175530144678 group by v28,v24;
create or replace view aggJoin4492835103401028547 as (
with aggView8912253485953543312 as (select v17, MIN(v2) as v39 from aggView1717097571884043917 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView8912253485953543312 where mc.company_id=aggView8912253485953543312.v17);
create or replace view aggJoin6562458109631672887 as (
with aggView2437340356231567388 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView2437340356231567388 where ml.link_type_id=aggView2437340356231567388.v13);
create or replace view aggJoin97900913689637085 as (
with aggView3094039959014661294 as (select v24, MIN(v40) as v40 from aggJoin6562458109631672887 group by v24,v40)
select v28, v24, v40 from aggView6388006244237411863 join aggView3094039959014661294 using(v24));
create or replace view aggJoin4925378578153549824 as (
with aggView2006101757200880539 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin4492835103401028547 join aggView2006101757200880539 using(v18));
create or replace view aggJoin9035819418495196007 as (
with aggView6196750876010052072 as (select v24, MIN(v39) as v39 from aggJoin4925378578153549824 group by v24,v39)
select v28, v40 as v40, v39 from aggJoin97900913689637085 join aggView6196750876010052072 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin9035819418495196007;
