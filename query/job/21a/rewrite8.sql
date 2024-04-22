create or replace view aggView4515013275158856561 as select id as v29, title as v33 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggView8710346054031582609 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin1729992596111107035 as (
with aggView5809689866843212694 as (select v17, MIN(v2) as v44 from aggView8710346054031582609 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView5809689866843212694 where mc.company_id=aggView5809689866843212694.v17);
create or replace view aggJoin4996807808617424221 as (
with aggView971418742558852000 as (select v29, MIN(v33) as v46 from aggView4515013275158856561 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView971418742558852000 where ml.movie_id=aggView971418742558852000.v29);
create or replace view aggJoin1384932244723527348 as (
with aggView3503150679035032487 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3503150679035032487 where mk.keyword_id=aggView3503150679035032487.v27);
create or replace view aggJoin8002557060049055175 as (
with aggView2421685244611232855 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v29 from aggJoin1384932244723527348 join aggView2421685244611232855 using(v29));
create or replace view aggJoin3487151781578444638 as (
with aggView4890116638500633358 as (select v29 from aggJoin8002557060049055175 group by v29)
select v29, v13, v46 as v46 from aggJoin4996807808617424221 join aggView4890116638500633358 using(v29));
create or replace view aggJoin4237073292749455360 as (
with aggView3816590863083315683 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin1729992596111107035 join aggView3816590863083315683 using(v18));
create or replace view aggJoin8917902580687744277 as (
with aggView5068173019103279879 as (select v29, MIN(v44) as v44 from aggJoin4237073292749455360 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin3487151781578444638 join aggView5068173019103279879 using(v29));
create or replace view aggJoin1504124865264814989 as (
with aggView1871942197458125452 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin8917902580687744277 group by v13,v46,v44)
select link as v14, v46, v44 from link_type as lt, aggView1871942197458125452 where lt.id=aggView1871942197458125452.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin1504124865264814989;
