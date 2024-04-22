create or replace view aggJoin129565312384692492 as (
with aggView9009529558508080890 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView9009529558508080890 where ml.link_type_id=aggView9009529558508080890.v13);
create or replace view aggJoin2988583608861603137 as (
with aggView4553570480675183303 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView4553570480675183303 where mc.company_id=aggView4553570480675183303.v17);
create or replace view aggJoin9199739345472569252 as (
with aggView3344752690097873903 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3344752690097873903 where mk.keyword_id=aggView3344752690097873903.v27);
create or replace view aggJoin2594237194844647468 as (
with aggView6699444163188138877 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29, v18, v44 as v44 from aggJoin2988583608861603137 join aggView6699444163188138877 using(v29));
create or replace view aggJoin4963602989412091647 as (
with aggView2947245573488786720 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin2594237194844647468 join aggView2947245573488786720 using(v18));
create or replace view aggJoin1380797511747245555 as (
with aggView4462886606688625594 as (select v29, MIN(v44) as v44 from aggJoin4963602989412091647 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView4462886606688625594 where t.id=aggView4462886606688625594.v29 and production_year<=2000 and production_year>=1950);
create or replace view aggJoin8018842502769648444 as (
with aggView2488202159567253037 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin1380797511747245555 group by v29,v44)
select v29, v45 as v45, v44, v46 from aggJoin129565312384692492 join aggView2488202159567253037 using(v29));
create or replace view aggJoin5476999127268715123 as (
with aggView3628386274118442364 as (select v29, MIN(v45) as v45, MIN(v44) as v44, MIN(v46) as v46 from aggJoin8018842502769648444 group by v29,v46,v44,v45)
select v45, v44, v46 from aggJoin9199739345472569252 join aggView3628386274118442364 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin5476999127268715123;
