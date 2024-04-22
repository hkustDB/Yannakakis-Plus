create or replace view aggJoin1716018807950145080 as (
with aggView5624924146062753126 as (select name as v25, id as v24 from name as n where name_pcode_cf>='A' and name_pcode_cf<='F')
select v24, v25 from aggView5624924146062753126 where v25 LIKE 'A%');
create or replace view aggJoin9039174237125518185 as (
with aggView684035166488935693 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView684035166488935693 where pi.info_type_id=aggView684035166488935693.v16);
create or replace view aggJoin4404746043188138362 as (
with aggView7340751930273147690 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView7340751930273147690 where ml.linked_movie_id=aggView7340751930273147690.v38);
create or replace view aggJoin663318132554373553 as (
with aggView811438864770535344 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin4404746043188138362 join aggView811438864770535344 using(v18));
create or replace view aggJoin7226620917648277496 as (
with aggView4268185305019766336 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v36 from aggJoin9039174237125518185 join aggView4268185305019766336 using(v24));
create or replace view aggJoin3436314631101830252 as (
with aggView2299808371572034426 as (select v38 from aggJoin663318132554373553 group by v38)
select person_id as v24 from cast_info as ci, aggView2299808371572034426 where ci.movie_id=aggView2299808371572034426.v38);
create or replace view aggJoin1167959244607391536 as (
with aggView4941077460032893952 as (select v24 from aggJoin3436314631101830252 group by v24)
select v24, v36 from aggJoin7226620917648277496 join aggView4941077460032893952 using(v24));
create or replace view aggView3392505908513872766 as select v24, v36 from aggJoin1167959244607391536 group by v24,v36;
create or replace view aggJoin4492584868380865506 as (
with aggView6797788081434890095 as (select v24, MIN(v25) as v50 from aggJoin1716018807950145080 group by v24)
select v36, v50 from aggView3392505908513872766 join aggView6797788081434890095 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin4492584868380865506;
