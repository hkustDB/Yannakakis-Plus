create or replace view aggJoin7488471345323669179 as (
with aggView6296026144421702259 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView6296026144421702259 where ml.link_type_id=aggView6296026144421702259.v13);
create or replace view aggJoin8748150564550259980 as (
with aggView3574115622576772111 as (select id as v29, title as v46 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView3574115622576772111 where mc.movie_id=aggView3574115622576772111.v29);
create or replace view aggJoin7812584078231800492 as (
with aggView2372329420575156490 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select v29, v18, v46, v44 from aggJoin8748150564550259980 join aggView2372329420575156490 using(v17));
create or replace view aggJoin2001778519924808288 as (
with aggView5869174493357067086 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView5869174493357067086 where mk.keyword_id=aggView5869174493357067086.v27);
create or replace view aggJoin929245470338944263 as (
with aggView6040203713076917318 as (select v29, MIN(v45) as v45 from aggJoin7488471345323669179 group by v29,v45)
select movie_id as v29, info as v23, v45 from movie_info as mi, aggView6040203713076917318 where mi.movie_id=aggView6040203713076917318.v29 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin923934079141633480 as (
with aggView7603303480409666228 as (select v29, MIN(v45) as v45 from aggJoin929245470338944263 group by v29,v45)
select v29, v45 from aggJoin2001778519924808288 join aggView7603303480409666228 using(v29));
create or replace view aggJoin5960105673963808902 as (
with aggView6080559460052836865 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin7812584078231800492 join aggView6080559460052836865 using(v18));
create or replace view aggJoin8383872189725568085 as (
with aggView3503959365772320967 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin5960105673963808902 group by v29,v46,v44)
select v45 as v45, v46, v44 from aggJoin923934079141633480 join aggView3503959365772320967 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin8383872189725568085;
