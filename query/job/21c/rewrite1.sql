create or replace view aggJoin1999884257203058841 as (
with aggView35230478268165734 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView35230478268165734 where mc.company_id=aggView35230478268165734.v17);
create or replace view aggJoin7263159203636476668 as (
with aggView7115980185377933914 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView7115980185377933914 where ml.link_type_id=aggView7115980185377933914.v13);
create or replace view aggJoin7953315370393458913 as (
with aggView9055943351078037722 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1999884257203058841 join aggView9055943351078037722 using(v18));
create or replace view aggJoin4765985395768732035 as (
with aggView3205752938372540377 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3205752938372540377 where mk.keyword_id=aggView3205752938372540377.v27);
create or replace view aggJoin8679094006812200553 as (
with aggView7259292173643062331 as (select v29, MIN(v44) as v44 from aggJoin7953315370393458913 group by v29,v44)
select id as v29, title as v33, production_year as v36, v44 from title as t, aggView7259292173643062331 where t.id=aggView7259292173643062331.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin1741962713633765104 as (
with aggView8320924349941655150 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin8679094006812200553 group by v29,v44)
select movie_id as v29, info as v23, v44, v46 from movie_info as mi, aggView8320924349941655150 where mi.movie_id=aggView8320924349941655150.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin7181551207607818729 as (
with aggView4378984473836021443 as (select v29, MIN(v45) as v45 from aggJoin7263159203636476668 group by v29,v45)
select v29, v23, v44 as v44, v46 as v46, v45 from aggJoin1741962713633765104 join aggView4378984473836021443 using(v29));
create or replace view aggJoin412258406612271143 as (
with aggView1243000340332617618 as (select v29, MIN(v44) as v44, MIN(v46) as v46, MIN(v45) as v45 from aggJoin7181551207607818729 group by v29,v44,v46,v45)
select v44, v46, v45 from aggJoin4765985395768732035 join aggView1243000340332617618 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin412258406612271143;
