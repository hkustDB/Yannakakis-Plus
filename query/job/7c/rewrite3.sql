create or replace view aggJoin6020112257740376298 as (
with aggView2334094032237433024 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView2334094032237433024 where pi.info_type_id=aggView2334094032237433024.v16);
create or replace view aggJoin94014387674679013 as (
with aggView8386236800537212963 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView8386236800537212963 where ml.link_type_id=aggView8386236800537212963.v18);
create or replace view aggJoin1797164307342718411 as (
with aggView6350477547457914962 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView6350477547457914962 where ci.movie_id=aggView6350477547457914962.v38);
create or replace view aggJoin3508595943853054834 as (
with aggView3556717017800758806 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView3556717017800758806 where n.id=aggView3556717017800758806.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin2608663806174046291 as (
with aggView1791963823480280500 as (select v25, v24 from aggJoin3508595943853054834 group by v25,v24)
select v24, v25 from aggView1791963823480280500 where v25 LIKE 'A%');
create or replace view aggJoin2299026900802796925 as (
with aggView737520152175210351 as (select v38 from aggJoin94014387674679013 group by v38)
select v24 from aggJoin1797164307342718411 join aggView737520152175210351 using(v38));
create or replace view aggJoin3005639096370423932 as (
with aggView4591522020442143438 as (select v24 from aggJoin2299026900802796925 group by v24)
select v24, v36 from aggJoin6020112257740376298 join aggView4591522020442143438 using(v24));
create or replace view aggView2897212369212513422 as select v24, v36 from aggJoin3005639096370423932 group by v24,v36;
create or replace view aggJoin312004413279944834 as (
with aggView3376100494506373582 as (select v24, MIN(v25) as v50 from aggJoin2608663806174046291 group by v24)
select v36, v50 from aggView2897212369212513422 join aggView3376100494506373582 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin312004413279944834;
