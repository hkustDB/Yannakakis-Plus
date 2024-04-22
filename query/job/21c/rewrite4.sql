create or replace view aggView3403322592173703491 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8780096222798143068 as (
with aggView8209172232140721007 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView8209172232140721007 where t.id=aggView8209172232140721007.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView3905985708800284072 as select v33, v29 from aggJoin8780096222798143068 group by v33,v29;
create or replace view aggJoin1876605696954093452 as (
with aggView5403013349925246850 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView5403013349925246850 where ml.link_type_id=aggView5403013349925246850.v13);
create or replace view aggJoin5961029994270179485 as (
with aggView2752535852124104117 as (select v17, MIN(v2) as v44 from aggView3403322592173703491 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView2752535852124104117 where mc.company_id=aggView2752535852124104117.v17);
create or replace view aggJoin3367659056106697668 as (
with aggView5231175866780403786 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin5961029994270179485 join aggView5231175866780403786 using(v18));
create or replace view aggJoin2213110595443970042 as (
with aggView6586924850552328584 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView6586924850552328584 where mk.keyword_id=aggView6586924850552328584.v27);
create or replace view aggJoin6850359073809389714 as (
with aggView8487382323387581644 as (select v29 from aggJoin2213110595443970042 group by v29)
select v29, v44 as v44 from aggJoin3367659056106697668 join aggView8487382323387581644 using(v29));
create or replace view aggJoin1863414217218117382 as (
with aggView6019043449262927407 as (select v29, MIN(v44) as v44 from aggJoin6850359073809389714 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin1876605696954093452 join aggView6019043449262927407 using(v29));
create or replace view aggJoin3110906250217487216 as (
with aggView4080053956909467945 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin1863414217218117382 group by v29,v44,v45)
select v33, v45, v44 from aggView3905985708800284072 join aggView4080053956909467945 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin3110906250217487216;
