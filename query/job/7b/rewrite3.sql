create or replace view aggJoin7242765835289978725 as (
with aggView2262971681303513011 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView2262971681303513011 where n.id=aggView2262971681303513011.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggView1560502216202415548 as select v25, v24 from aggJoin7242765835289978725 group by v25,v24;
create or replace view aggJoin9207886000333556646 as (
with aggView4358396570761575398 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView4358396570761575398 where ml.link_type_id=aggView4358396570761575398.v18);
create or replace view aggJoin6185178964713972228 as (
with aggView2426639940987178372 as (select v38 from aggJoin9207886000333556646 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView2426639940987178372 where t.id=aggView2426639940987178372.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggView1385023482207356683 as select v38, v39 from aggJoin6185178964713972228 group by v38,v39;
create or replace view aggJoin6837127643601792587 as (
with aggView8765488809707435263 as (select v24, MIN(v25) as v50 from aggView1560502216202415548 group by v24)
select person_id as v24, movie_id as v38, v50 from cast_info as ci, aggView8765488809707435263 where ci.person_id=aggView8765488809707435263.v24);
create or replace view aggJoin1701495481748006054 as (
with aggView4580618470183221027 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView4580618470183221027 where pi.info_type_id=aggView4580618470183221027.v16 and note= 'Volker Boehm');
create or replace view aggJoin8084469825421768745 as (
with aggView125218113182779891 as (select v24 from aggJoin1701495481748006054 group by v24)
select v38, v50 as v50 from aggJoin6837127643601792587 join aggView125218113182779891 using(v24));
create or replace view aggJoin4038138569981157587 as (
with aggView5788884564852910744 as (select v38, MIN(v50) as v50 from aggJoin8084469825421768745 group by v38,v50)
select v39, v50 from aggView1385023482207356683 join aggView5788884564852910744 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin4038138569981157587;
